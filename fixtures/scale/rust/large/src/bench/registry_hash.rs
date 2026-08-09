use crate::bench::entry::BenchEntry;
use crate::ciphers::{adler32, crc32, djb2, fnv1a, jenkins, pearson, sdbm};

/// The hash families, in display order.
pub fn hash_entries() -> Vec<BenchEntry> {
    vec![
        BenchEntry::new(fnv1a::FNV1A_ID, fnv1a::fnv1a_category(), fnv1a::runner::fnv1a_verify, fnv1a::bench::fnv1a_measure, fnv1a::keys::fnv1a_key_label),
        BenchEntry::new(djb2::DJB2_ID, djb2::djb2_category(), djb2::runner::djb2_verify, djb2::bench::djb2_measure, djb2::keys::djb2_key_label),
        BenchEntry::new(sdbm::SDBM_ID, sdbm::sdbm_category(), sdbm::runner::sdbm_verify, sdbm::bench::sdbm_measure, sdbm::keys::sdbm_key_label),
        BenchEntry::new(adler32::ADLER32_ID, adler32::adler32_category(), adler32::runner::adler32_verify, adler32::bench::adler32_measure, adler32::keys::adler32_key_label),
        BenchEntry::new(crc32::CRC32_ID, crc32::crc32_category(), crc32::runner::crc32_verify, crc32::bench::crc32_measure, crc32::keys::crc32_key_label),
        BenchEntry::new(jenkins::JENKINS_ID, jenkins::jenkins_category(), jenkins::runner::jenkins_verify, jenkins::bench::jenkins_measure, jenkins::keys::jenkins_key_label),
        BenchEntry::new(pearson::PEARSON_ID, pearson::pearson_category(), pearson::runner::pearson_verify, pearson::bench::pearson_measure, pearson::keys::pearson_key_label),
    ]
}
