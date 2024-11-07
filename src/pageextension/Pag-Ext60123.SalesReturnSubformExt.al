pageextension 60123 "Sales Return Subform Ext" extends "Sales Return Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Job No."; rec."Job No.")
            {
                ApplicationArea = All;
            }
            field("Job Task No."; rec."Job Task No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
