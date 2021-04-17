module test (
    input clk,
    input rst,
    input pulse,
    output led
);
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    reg [1:0] current_state;
    reg [1:0] next_state;

    always @ *
    begin
        if (pulse)
        begin
            // next_state = next_state + 1;
            case (current_state)
            A: next_state = B;
            B: next_state = C;
            C: next_state = D;
            D: next_state = A;
            endcase
        end
        else
        begin
            next_state = current_state;
        end
    end

    always @ (posedge clk or posedge rst)
    begin
        if (rst) current_state <= A;
        else current_state <= next_state;
    end

    assign led = (current_state == D);
endmodule