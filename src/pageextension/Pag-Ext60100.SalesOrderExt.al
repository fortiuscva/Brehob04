pageextension 60100 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addafter("External Document No.")
        {
            field("P.O. Required"; Rec."P.O. Required")
            {
                ApplicationArea = all;
                Caption = 'P.O. Required';
                ToolTip = 'If checked, a purchase order is required from the customer.';
            }
        }
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
            field("Job No."; rec."Job No.")
            {
                applicationarea = all;
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action("Create Job")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    rec.setrange("No.", rec."No.");
                    Report.Run(60102, false, false, rec);
                end;
            }
        }
    }
}
