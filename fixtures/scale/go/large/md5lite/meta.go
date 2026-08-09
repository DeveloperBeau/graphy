package md5lite

// Md5liteName identifies this hash family in reports and registries.
const Md5liteName = "md5lite"

// Md5liteDescribe returns a short human-readable summary of the algorithm.
func Md5liteDescribe() string {
	return "deterministic md5lite byte-mixing digest over arbitrary input"
}
