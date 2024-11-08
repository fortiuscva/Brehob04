pageextension 60132 "Job List Ext" extends "Job List"
{
    layout
    {
        addafter(Status)
        {
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = all;
                Caption = 'Salesperson Code';
            }
        /*  Becomes part of base app in version 24.2.19279.0
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
                Caption = 'External Document No.';
            }
            */
        }
    }
}
