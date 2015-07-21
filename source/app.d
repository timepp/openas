import std.stdio;
import std.string;
import std.getopt;
import std.file;
import std.path;
import std.process;

void DeleteFiles(string dir, string pattern)
{
    auto files = std.file.dirEntries(dir, pattern, std.file.SpanMode.shallow);
    foreach(f; files)
    {
        std.file.remove(f);
    }
}

int main(string[] argv)
{
    bool showHelp = false;
    getopt(argv, "help|h", &showHelp);

    if (argv.length <= 1)
    {
        showHelp = true;
    }

    if (showHelp)
    {
        writeln("openas 1.0.0\n"
                "save stream and open it as specific file type. \n"
                "\n"
                "usage: openas <extension>\n"
                "\n"
                "example:\n"
                "  echo 'a->b->c' | dot2dgml | openas dgml\n"
                );
        return 0;
    }

    string tempdir = std.file.tempDir();
    DeleteFiles(tempdir, "openas_temp.*");

    string fileName = std.path.buildPath(tempdir, "openas_temp." ~ argv[1]);
    File(fileName, "w").writeln(readln(0));

    std.process.browse(fileName);

    return 0;
}
