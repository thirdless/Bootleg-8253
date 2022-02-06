module TIMER (clk, reset, di, cs, wr, a0, out);

    input clk, reset, cs, wr, a0;
    input [15:0] di;
    output out;

    //fire pentru iesirile ce nu sunt folosite
    wire VOID;
    wire [15:0] VOID16;

    //declaratii

    wire resinit, plnif, plmodif, valid, plrn, plrmod, p1, p2, os, osa, c1, c2, ch, inccnt, rescnt, respln, plnact, resplmod, plmodact;
    wire [2:0] rmodif_out, mux3_out, rmod_out, data_mux3;
    wire [15:0] rnif_out, mux16_out, rn_out, add_out, dec1_out, dec2_out, dec3_out, outcnt;

    assign plnif = cs && wr && !a0;
    assign plmodif = cs && wr && a0;
    assign plrn = (!valid && plnif) || (valid && (((p1 || p2) && c1) || (os && osa && plnact && c1) || (os && !osa && plnif)));
    assign plmod = (!valid && plmodif) || (valid && (((p1 || p2) && c2) || (os && osa && plmodact && c2) || (os && !osa && plmodif) || ((!(p1 || p2 || os)) && plnif)));
    assign respln = reset || (valid && (((p1 || p2) && c1) || (os && osa && c1)));
    assign resplmod = reset || valid && ((p1 || p2) && c1 || os && osa && c1);
    assign rescnt = reset || (valid && c1) || resinit;
    assign inccnt = valid && (p1 || p2 || osa);

    //instantieri

    ADD ADD(rn_out, add_out);
    CONTROL CONTROL(clk, reset, plnif, plmodif, p1, p2, os, c1, plnact, valid, osa, resinit);
    CMP CMP1(dec1_out, outcnt, c1, VOID);
    CMP CMP2(dec2_out, outcnt, c2, VOID);
    CMP CMP3(dec3_out, outcnt, ch, VOID);
    CNT CNT(clk, reset, inccnt, outcnt);
    DEC DEC1(rn_out, dec1_out, VOID16);
    DEC DEC2(dec1_out, dec2_out, VOID16);
    DEC DEC3(add_out, dec3_out, VOID16);
    LC LC(rmod_out, p1, p2, os);
    MUX_1_2_3B MUX_1_2_3B(rmodif_out, data_mux3, valid, mux3_out);
    MUX_1_2_16B MUX_1_2_16B(rnif_out, di, valid, mux16_out);
    RMOD RMOD(clk, reset, plrmod, mux3_out, rmod_out);
    RMODIF RMODIF(data_mux3, plmodif, reset, clk, rmodif_out);
    RN RN(clk, reset, plrn, mux16_out, rn_out);
    RNIF RNIF(di, plnif, reset, clk, rnif_out);
    OUT_GEN OUT_GEN(valid, p1, p2, os, osa, c1, ch, out_value);

    assign out = out_value;

endmodule