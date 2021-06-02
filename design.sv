// 3x8 decode verilog design

module decoder_3x8(in,
                   en,
                   out
                   );

    input en;            // enable signal
    input [2:0] in;      // input lines
    output reg [7:0]out; // output lines

    always@(en or in)
        begin
            if(en==1'b1)
                begin
                    case(in)
                        3'b000:out=8'b0000_0001;
                        3'b001:out=8'b0000_0010;
                        3'b010:out=8'b0000_0100;
                        3'b011:out=8'b0000_1000;
                        3'b100:out=8'b0001_0000;
                        3'b101:out=8'b0010_0000;
                        3'b110:out=8'b0100_0000;
                        3'b111:out=8'b1000_0000;
                        default:out=8'bx;
                    endcase
                end
            else
                begin
                    out=8'b0000_0000;
                end
        end

endmodule
