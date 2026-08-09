package textprinter.model;

public class RenderOptions {
    private String align = "left";
    private int width = 60;
    private String frameName = "ascii";
    private String themeName = "plain";

    public String getAlign() { return align; }
    public void setAlign(String align) { this.align = align; }

    public int getWidth() { return width; }
    public void setWidth(int width) { this.width = Math.max(8, width); }

    public String getFrameName() { return frameName; }
    public void setFrameName(String frameName) { this.frameName = frameName; }

    public String getThemeName() { return themeName; }
    public void setThemeName(String themeName) { this.themeName = themeName; }
}
