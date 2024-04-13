# More on strings

```
type String = [Char]
```
Quite inefficient


### Alternatives to strings:
1. Text
    - Efficient Unicode based text
2. ByteString
    - Text stored as collection of bytes
    - Since bytes, can only use ASCII, not Unicode
    - Lazy bystring (good amortized performance), String bytestring (good performance for smaller data)