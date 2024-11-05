pageextension 60104 "Sales Quote Ext" extends "Sales Quote"
{
    layout
    {
        addafter(Status)
        {
            field("Job Required"; rec."Job Required")
            {
                applicationarea = all;
            }
            field("Job Type"; rec."Job Type")
            {
                applicationarea = all;
            }
        }
        addbefore("External Document No.")
        {
            field("P.O. Required"; Rec."P.O. Required")
            {
                ApplicationArea = all;
                Caption = 'P.O. Required';
                ToolTip = 'If checked, a purchase order is required from the customer.';
            }
        }
    }
}
