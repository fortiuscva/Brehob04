pageextension 60125 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("P.O. Required"; rec."P.O. Required")
            {
                ApplicationArea = all;
                Caption = 'P.O. Required';
                ToolTip = 'If checked, a purchase order is required from the customer.';
            }
        }
        modify("Bill-to Customer No.")
        {
            caption = 'Bill-to Customer No.';
        }
    }
}
