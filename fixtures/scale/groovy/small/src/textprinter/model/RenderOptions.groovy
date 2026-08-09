package textprinter.model

class RenderOptions {
    String align = "left"
    int width = 60
    String frameName = "ascii"

    RenderOptions normalized() {
        RenderOptions copy = new RenderOptions()
        copy.align = align
        copy.width = Math.max(8, Math.min(200, width))
        copy.frameName = frameName
        return copy
    }
}
