open Config

type session = { done_count : int; cfg : config }

let begin_session = { done_count = 0; cfg = defaults }

let step s = { s with done_count = Progress.tick s.done_count }
