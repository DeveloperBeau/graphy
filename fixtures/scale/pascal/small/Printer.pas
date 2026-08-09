program Printer;

uses UArgs, UDocument, UReader, UWriter, UPalette;

var
  Opts: TOptions;
  Doc: TDocument;

begin
  Opts := ParseArgs;
  InitDocument(Doc, Opts.Heading);
  LoadSample(Doc);
  RenderDocument(pBright, Opts.BoxWidth, Doc);
end.
