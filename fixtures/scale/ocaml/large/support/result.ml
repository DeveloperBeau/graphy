type test_result = { subject : string; passed : bool }

let pass name = { subject = name; passed = true }

let fail name = { subject = name; passed = false }

let ok r = r.passed
