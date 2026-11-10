using DataEngine;

namespace DataEngine.Tests;

public sealed class FieldValuesTests
{
    [Theory]
    [InlineData("42", 42)]
    [InlineData(" -7 ", -7)]
    [InlineData("3.5", 3.5)]
    [InlineData("1,234.50", 1234.50)]
    public void Coerce_Number_ReturnsDecimal(string raw, decimal expected)
    {
        var value = FieldValues.Coerce(FieldType.Number, raw);

        Assert.Equal(expected, Assert.IsType<decimal>(value));
    }

    [Theory]
    [InlineData("true", true)]
    [InlineData("YES", true)]
    [InlineData("1", true)]
    [InlineData("false", false)]
    [InlineData("No", false)]
    [InlineData("0", false)]
    public void Coerce_Boolean_AcceptsCommonSpellings(string raw, bool expected)
    {
        var value = FieldValues.Coerce(FieldType.Boolean, raw);

        Assert.Equal(expected, Assert.IsType<bool>(value));
    }

    [Fact]
    public void Coerce_Date_ReturnsDateOnly()
    {
        var value = FieldValues.Coerce(FieldType.Date, "2026-11-11");

        Assert.Equal(new DateOnly(2026, 11, 11), Assert.IsType<DateOnly>(value));
    }

    [Fact]
    public void Coerce_Text_PreservesWhitespace()
    {
        Assert.Equal("  hello  ", FieldValues.Coerce(FieldType.Text, "  hello  "));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("   ")]
    public void Coerce_EmptyInput_ReturnsNull(string? raw)
    {
        Assert.Null(FieldValues.Coerce(FieldType.Number, raw));
    }

    [Theory]
    [InlineData(FieldType.Number, "not-a-number")]
    [InlineData(FieldType.Boolean, "maybe")]
    [InlineData(FieldType.Date, "11/11/2026 3pm")]
    public void Coerce_InvalidInput_ThrowsFormatException(FieldType type, string raw)
    {
        Assert.Throws<FormatException>(() => FieldValues.Coerce(type, raw));
    }
}
