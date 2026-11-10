using System.Globalization;

namespace DataEngine;

/// <summary>
/// Coerces raw user input into the CLR value for a field type.
/// Validation happens here, at the module edge, regardless of what the UI checked.
/// </summary>
public static class FieldValues
{
    /// <summary>
    /// Coerces <paramref name="raw"/> to the value shape of <paramref name="type"/>.
    /// Null or whitespace yields <c>null</c> (an empty value), not a default.
    /// </summary>
    /// <exception cref="FormatException">The raw value is not valid for the field type.</exception>
    public static object? Coerce(FieldType type, string? raw)
    {
        if (raw is null)
        {
            return null;
        }

        var trimmed = raw.Trim();
        if (trimmed.Length == 0)
        {
            return null;
        }

        return type switch
        {
            FieldType.Text => raw,
            FieldType.Number => CoerceNumber(trimmed),
            FieldType.Boolean => CoerceBoolean(trimmed),
            FieldType.Date => CoerceDate(trimmed),
            _ => throw new ArgumentOutOfRangeException(nameof(type), type, "Unsupported field type."),
        };
    }

    private static decimal CoerceNumber(string raw)
    {
        if (decimal.TryParse(raw, NumberStyles.Number, CultureInfo.InvariantCulture, out var value))
        {
            return value;
        }

        throw new FormatException($"'{raw}' is not a valid number.");
    }

    private static bool CoerceBoolean(string raw)
    {
        return raw.ToLowerInvariant() switch
        {
            "true" or "1" => true,
            "false" or "0" => false,
            _ => throw new FormatException($"'{raw}' is not a valid boolean."),
        };
    }

    private static DateOnly CoerceDate(string raw)
    {
        if (DateOnly.TryParse(raw, CultureInfo.InvariantCulture, DateTimeStyles.None, out var value))
        {
            return value;
        }

        throw new FormatException($"'{raw}' is not a valid date (expected yyyy-MM-dd).");
    }
}
