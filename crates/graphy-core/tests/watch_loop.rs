//! Integration test for the watch loop. Spawns `watch` on a temp directory,
//! mutates a tracked file, then verifies the output bundle is rebuilt.
//!
//! Threaded shutdown is deliberately heavy-handed (the watcher blocks on a
//! channel) — we leak the thread once the assertions pass. The temp dir
//! survives via `TempDir::into_path` so post-leak file activity is harmless.

use std::fs;
use std::sync::mpsc;
use std::thread;
use std::time::{Duration, Instant};

use graphy_core::pipeline::PipelineConfig;
use tempfile::tempdir;

#[test]
fn watch_rebuilds_after_a_tracked_file_change() {
    let dir = tempdir().unwrap();
    let path = dir.path().to_path_buf();
    fs::write(path.join("a.rs"), "pub fn f(){}\n").unwrap();

    let (ready_tx, ready_rx) = mpsc::sync_channel::<()>(1);
    let watch_root = path.clone();

    thread::spawn(move || {
        let cfg = PipelineConfig::new(&watch_root);
        // Run once synchronously so the initial graph.json exists before we
        // signal readiness, then enter the blocking watch loop.
        let _ = graphy_core::pipeline::Pipeline::new(cfg.clone()).run();
        let _ = ready_tx.send(());
        let _ = graphy_core::watch::watch(cfg);
    });

    ready_rx.recv_timeout(Duration::from_secs(10)).expect("watch did not start");

    let graph_path = path.join("graphy-out").join("graph.json");
    let baseline = fs::metadata(&graph_path).unwrap().modified().unwrap();

    // Give notify a moment to install its watches, then mutate a tracked file.
    thread::sleep(Duration::from_millis(400));
    fs::write(path.join("a.rs"), "pub fn f(){}\npub fn g(){}\n").unwrap();

    let deadline = Instant::now() + Duration::from_secs(8);
    while Instant::now() < deadline {
        if let Ok(m) = fs::metadata(&graph_path)
            && m.modified().unwrap() > baseline {
                return;
            }
        thread::sleep(Duration::from_millis(100));
    }
    panic!("watch did not rebuild graph.json within 8s");
}
