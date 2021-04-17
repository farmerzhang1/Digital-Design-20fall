module encoder(input i7, input i6, input i5, input i4, input i3, input i2, input i1, input i0, output y2, output y1, output y0);
    assign y2 = i7 | ~i7 & i6 | ~i7 & ~i6 & i5 | ~i7 & ~i6 & ~i5 & i4;
    assign y1 = i7 | ~i7 & i6 | ~i7 & ~i6 & ~i5 & ~i4 & i3 | ~i7 & ~i6 & ~i5 & ~i4 & ~i3 & i2;
    assign y0 = i7 | ~i7 & ~i6 & i5 | ~i7 & ~i6 & ~i5 & ~i4 & i3 | ~i7 & ~i6& ~i5 & ~i4 & ~i3 & ~i2 & i1;
endmodule
