//! Stable C ABI for graphy language plugins.
//!
//! A plugin is a `cdylib` exporting the following symbols:
//!
//! ```c
//! extern uint32_t graphy_plugin_abi_version(void);
//! extern const GraphyPluginMetadata *graphy_plugin_metadata(void);
//! extern GraphyPluginExtractResult graphy_plugin_extract(
//!     const char *path_utf8,
//!     size_t path_len,
//!     const uint8_t *src,
//!     size_t src_len
//! );
//! extern void graphy_plugin_free(GraphyPluginExtractResult result);
//! ```
//!
//! The host calls `graphy_plugin_abi_version` first and refuses to load
//! plugins whose version does not match `ABI_VERSION`. `metadata` returns
//! a pointer to a static descriptor (plugin owns the storage). `extract`
//! returns either a UTF-8 JSON-serialized `ExtractionOutput` blob plus a
//! status code, or an error message. The blob is freed by the host via
//! `graphy_plugin_free`.
//!
//! The JSON payload must be valid `graphy_core::schema::ExtractionOutput`.
//!
//! This crate intentionally has no runtime dependencies — both the host
//! and plugins should compile against it cheaply.

use core::ffi::{c_char, c_uint};

#[cfg(feature = "helpers")]
pub mod helpers;

/// Bumped on any breaking change to the ABI. Plugins compiled against an
/// older or newer version are refused at load time.
pub const ABI_VERSION: u32 = 1;

/// Returned by `graphy_plugin_extract`. The fields are owned by the plugin
/// and must be released through `graphy_plugin_free`.
#[repr(C)]
#[derive(Debug)]
pub struct GraphyPluginExtractResult {
    /// `STATUS_OK` on success; nonzero on error.
    pub status: c_uint,
    /// JSON-serialized `ExtractionOutput` bytes. Borrowed from the plugin
    /// until `graphy_plugin_free` is called.
    pub json_data: *mut u8,
    /// Length in bytes of `json_data`.
    pub json_len: usize,
    /// On error, an optional UTF-8 message (NUL-terminated). May be null.
    pub error_message: *mut c_char,
}

pub const STATUS_OK: c_uint = 0;
pub const STATUS_PARSE_ERROR: c_uint = 1;
pub const STATUS_IO_ERROR: c_uint = 2;
pub const STATUS_INTERNAL_ERROR: c_uint = 3;

/// Static descriptor returned by `graphy_plugin_metadata`. All pointers
/// point into static memory owned by the plugin.
#[repr(C)]
#[derive(Debug)]
pub struct GraphyPluginMetadata {
    /// Plugin display name (NUL-terminated UTF-8).
    pub name: *const c_char,
    /// Plugin semver string (NUL-terminated UTF-8).
    pub version: *const c_char,
    /// Pointer to an array of `extension_count` NUL-terminated UTF-8
    /// extension strings (no leading dot, lowercase). Example: "rs", "rlib".
    pub extensions: *const *const c_char,
    /// Number of entries in `extensions`.
    pub extension_count: usize,
}

// The descriptors are immutable pointers to static data; they're safe to
// share across threads.
unsafe impl Sync for GraphyPluginMetadata {}

/// Generate every required FFI symbol from one macro call.
#[macro_export]
macro_rules! define_plugin {
    (
        name: $name:literal,
        extensions: [ $($ext:literal),+ $(,)? ],
        extract_json: $extract_fn:path $(,)?
    ) => {
        const _PLUGIN_EXT_PTRS: &[*const ::core::ffi::c_char] = &[
            $( concat!($ext, "\0").as_bytes().as_ptr() as *const ::core::ffi::c_char ),+
        ];
        static _PLUGIN_EXTENSIONS: $crate::ExtensionTable =
            $crate::ExtensionTable::new(_PLUGIN_EXT_PTRS);

        const _PLUGIN_NAME: &[u8] = concat!($name, "\0").as_bytes();
        const _PLUGIN_VERSION: &[u8] = concat!(env!("CARGO_PKG_VERSION"), "\0").as_bytes();

        static _PLUGIN_META: $crate::GraphyPluginMetadata =
            $crate::GraphyPluginMetadata {
                name: _PLUGIN_NAME.as_ptr() as *const ::core::ffi::c_char,
                version: _PLUGIN_VERSION.as_ptr() as *const ::core::ffi::c_char,
                extensions: _PLUGIN_EXTENSIONS.as_ptr(),
                extension_count: _PLUGIN_EXTENSIONS.len(),
            };

        #[unsafe(no_mangle)]
        pub extern "C" fn graphy_plugin_abi_version() -> u32 {
            $crate::ABI_VERSION
        }

        #[unsafe(no_mangle)]
        pub extern "C" fn graphy_plugin_metadata() -> *const $crate::GraphyPluginMetadata {
            &_PLUGIN_META
        }

        /// # Safety
        /// `path_utf8` / `src` must be valid for `path_len` / `src_len` bytes.
        #[unsafe(no_mangle)]
        pub unsafe extern "C" fn graphy_plugin_extract(
            path_utf8: *const ::core::ffi::c_char,
            path_len: usize,
            src: *const u8,
            src_len: usize,
        ) -> $crate::GraphyPluginExtractResult {
            let path_bytes = unsafe {
                ::core::slice::from_raw_parts(path_utf8 as *const u8, path_len)
            };
            let Ok(path) = ::core::str::from_utf8(path_bytes) else {
                return $crate::err_result($crate::STATUS_INTERNAL_ERROR, "path not utf-8");
            };
            let src_bytes = unsafe { ::core::slice::from_raw_parts(src, src_len) };
            let Ok(source) = ::core::str::from_utf8(src_bytes) else {
                return $crate::err_result($crate::STATUS_INTERNAL_ERROR, "source not utf-8");
            };
            match $extract_fn(path, source) {
                Ok(json) => $crate::ok_result(json),
                Err(e) => $crate::err_result($crate::STATUS_INTERNAL_ERROR, e),
            }
        }

        #[unsafe(no_mangle)]
        pub extern "C" fn graphy_plugin_free(result: $crate::GraphyPluginExtractResult) {
            unsafe { $crate::release_result(result) }
        }
    };
}

/// Thin SendSync wrapper around a static extension-pointer table. Plugins
/// construct one as a `static` and reference it from their metadata.
#[repr(transparent)]
pub struct ExtensionTable(pub &'static [*const c_char]);

// SAFETY: the contained `*const c_char` pointers reference static byte
// literals owned by the plugin and never mutated.
unsafe impl Sync for ExtensionTable {}
unsafe impl Send for ExtensionTable {}

impl ExtensionTable {
    pub const fn new(slice: &'static [*const c_char]) -> Self {
        Self(slice)
    }
    pub const fn as_ptr(&self) -> *const *const c_char {
        self.0.as_ptr()
    }
    pub const fn len(&self) -> usize {
        self.0.len()
    }
    pub const fn is_empty(&self) -> bool {
        self.0.is_empty()
    }
}

/// Helper invoked by plugin authors: ship JSON bytes as the success result,
/// transferring ownership to the caller (host). The host frees via
/// `graphy_plugin_free`.
#[inline]
pub fn ok_result(json: Vec<u8>) -> GraphyPluginExtractResult {
    let mut boxed = json.into_boxed_slice();
    let ptr = boxed.as_mut_ptr();
    let len = boxed.len();
    std::mem::forget(boxed);
    GraphyPluginExtractResult {
        status: STATUS_OK,
        json_data: ptr,
        json_len: len,
        error_message: core::ptr::null_mut(),
    }
}

/// Build an error result with an owned message. Message bytes are
/// NUL-terminated and ownership transfers to the host.
#[inline]
pub fn err_result(status: c_uint, msg: impl Into<String>) -> GraphyPluginExtractResult {
    let mut bytes = msg.into().into_bytes();
    bytes.push(0); // NUL
    let mut boxed = bytes.into_boxed_slice();
    let ptr = boxed.as_mut_ptr() as *mut c_char;
    std::mem::forget(boxed);
    GraphyPluginExtractResult {
        status,
        json_data: core::ptr::null_mut(),
        json_len: 0,
        error_message: ptr,
    }
}

/// Counterpart to `ok_result` / `err_result`: the host calls this through
/// the plugin's exported `graphy_plugin_free` symbol so allocator boundaries
/// are respected. Plugins should expose a `graphy_plugin_free` that
/// forwards here.
///
/// # Safety
///
/// `result` must have been produced by `ok_result` or `err_result` in the
/// same dynamic library invocation.
pub unsafe fn release_result(result: GraphyPluginExtractResult) {
    if !result.json_data.is_null() {
        let _ = unsafe {
            Box::from_raw(core::ptr::slice_from_raw_parts_mut(
                result.json_data,
                result.json_len,
            ))
        };
    }
    if !result.error_message.is_null() {
        // CString recovered via raw pointer; length is the NUL-terminated form.
        let _ = unsafe { std::ffi::CString::from_raw(result.error_message) };
    }
}
