type cell = { content : string; pad : int }

let text c = c.content

let width c = String.length c.content + c.pad
