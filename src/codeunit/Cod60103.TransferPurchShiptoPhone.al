codeunit 60103 "Transfer Purch.Ship to Phone"
{
    Subtype = Install;
    Permissions = tabledata "Purch. Inv. Header" = rmid, tabledata "Purch. Rcpt. Header" = rmid, tabledata "Purch. Cr. Memo Hdr." = rmid;

    trigger OnInstallAppPerCompany()
    begin
        TransferDataPurchaseShiptoPhone();
    end;

    procedure TransferDataPurchaseShiptoPhone()
    var
        PurchHdrRecLcl: Record "Purchase Header";
        PurchInvHdrRecLcl: Record "Purch. Inv. Header";
        PurchRcptHdrRecLcl: Record "Purch. Rcpt. Header";
        PurchCrMemoHdrRecLcl: Record "Purch. Cr. Memo Hdr.";
        PurchHdrArchRecLcl: Record "Purchase Header Archive";
    begin
        //Purchase Header
        PurchHdrRecLcl.Reset();
        if PurchHdrRecLcl.FindSet() then
            repeat
                PurchHdrRecLcl."BHB Ship-to Phone No." := PurchHdrRecLcl."Ship-to Phone No.";
                PurchHdrRecLcl.Modify();
            until PurchHdrRecLcl.Next() = 0;

        //Purchase Invoice
        PurchInvHdrRecLcl.Reset();
        if PurchInvHdrRecLcl.FindSet() then
            repeat
                PurchInvHdrRecLcl."BHB Ship-to Phone No." := PurchInvHdrRecLcl."Ship-to Phone No.";
                PurchInvHdrRecLcl.Modify();
            until PurchInvHdrRecLcl.Next() = 0;

        //Purchase Receipt
        PurchRcptHdrRecLcl.Reset();
        if PurchRcptHdrRecLcl.FindSet() then
            repeat
                PurchRcptHdrRecLcl."BHB Ship-to Phone No." := PurchRcptHdrRecLcl."Ship-to Phone No.";
                PurchRcptHdrRecLcl.Modify();
            until PurchRcptHdrRecLcl.Next() = 0;

        //Purchase CrMemo
        PurchCrMemoHdrRecLcl.Reset();
        if PurchCrMemoHdrRecLcl.FindSet() then
            repeat
                PurchCrMemoHdrRecLcl."BHB Ship-to Phone No." := PurchCrMemoHdrRecLcl."Ship-to Phone No.";
                PurchCrMemoHdrRecLcl.Modify();
            until PurchCrMemoHdrRecLcl.Next() = 0;

        //Purchase Archive
        PurchHdrArchRecLcl.Reset();
        if PurchHdrArchRecLcl.FindSet() then
            repeat
                PurchHdrArchRecLcl."BHB Ship-to Phone No." := PurchHdrArchRecLcl."Ship-to Phone No.";
                PurchHdrArchRecLcl.Modify();
            until PurchHdrArchRecLcl.Next() = 0;
    end;
}
