import std.stdio;
import std.file;
import std.datetime;

void main()
{
    foreach (DirEntry f; dirEntries(null, SpanMode.shallow))
    {
        //SysTime s = f.timeLastModified;
        writefln("%s %*s %s",
            getAttr(f.attributes), 8, formatsize(f.size), f.name);
    }
}

/**
 * Get attributes
 * Params: attr = Attributes
 * Returns: Character array
 */
char[7] getAttr(uint attr)
{
    char[7] a;
    version (Windows)
    {
        import core.sys.windows.windows;
        a[0] = attr & FILE_ATTRIBUTE_DIRECTORY ? 'd' : '-';
        a[1] = attr & FILE_ATTRIBUTE_READONLY ? 'r' : '-';
        a[2] = attr & FILE_ATTRIBUTE_SYSTEM ? 's' : '-';
        a[3] = attr & FILE_ATTRIBUTE_TEMPORARY ? 't' : '-';
        a[4] = attr & FILE_ATTRIBUTE_HIDDEN ? 'h' : '-';
        a[5] = attr & FILE_ATTRIBUTE_COMPRESSED ? 'c' : '-';
        a[6] = attr & FILE_ATTRIBUTE_ARCHIVE ? 'a' : '-';
    }
    else
    {

    }
    return a;
}

/// Get an ISO formatted size.
string formatsize(long size, bool b10 = false) //BUG: %f is unpure?
{
    import std.format : format;

    enum : long {
        KB = 1024,
        MB = KB * 1024,
        GB = MB * 1024,
        TB = GB * 1024,
        KiB = 1000,
        MiB = KiB * 1000,
        GiB = MiB * 1000,
        TiB = GiB * 1000
    }

    const float s = size;

    if (b10)
    {
        if (size > TiB)
            if (size > 100 * TiB)
                return format("%d TiB", size / TiB);
            else if (size > 10 * TiB)
                return format("%0.1f TiB", s / TiB);
            else
                return format("%0.2f TiB", s / TiB);
        else if (size > GiB)
            if (size > 100 * GiB)
                return format("%d GiB", size / GiB);
            else if (size > 10 * GiB)
                return format("%0.1f GiB", s / GiB);
            else
                return format("%0.2f GiB", s / GiB);
        else if (size > MiB)
            if (size > 100 * MiB)
                return format("%d MiB", size / MiB);
            else if (size > 10 * MiB)
                return format("%0.1f MiB", s / MiB);
            else
                return format("%0.2f MiB", s / MiB);
        else if (size > KiB)
            if (size > 100 * MiB)
                return format("%d KiB", size / KiB);
            else if (size > 10 * KiB)
                return format("%0.1f KiB", s / KiB);
            else
                return format("%0.2f KiB", s / KiB);
        else
            return format("%d B", size);
    }
    else
    {
        if (size > TB)
            if (size > 100 * TB)
                return format("%d TB", size / TB);
            else if (size > 10 * TB)
                return format("%0.1f TB", s / TB);
            else
                return format("%0.2f TB", s / TB);
        else if (size > GB)
            if (size > 100 * GB)
                return format("%d GB", size / GB);
            else if (size > 10 * GB)
                return format("%0.1f GB", s / GB);
            else
                return format("%0.2f GB", s / GB);
        else if (size > MB)
            if (size > 100 * MB)
                return format("%d MB", size / MB);
            else if (size > 10 * MB)
                return format("%0.1f MB", s / MB);
            else
                return format("%0.2f MB", s / MB);
        else if (size > KB)
            if (size > 100 * KB)
                return format("%d KB", size / KB);
            else if (size > 10 * KB)
                return format("%0.1f KB", s / KB);
            else
                return format("%0.2f KB", s / KB);
        else
            return format("%d B", size);
    }
}