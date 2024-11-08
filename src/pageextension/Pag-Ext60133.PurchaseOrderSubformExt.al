pageextension 60133 "Purchase Order Subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        addbefore("Tax Area Code")
        {
            field("FA Posting Type"; rec."FA Posting Type")
            {
                ApplicationArea = all;
                Caption = 'FA Posting Type';
            }
            field("Salvage Value"; Rec."Salvage Value")
            {
                ApplicationArea = all;
                Caption = 'Salvage Value';
            }
            field("Budgeted FA No."; Rec."Budgeted FA No.")
            {
                ApplicationArea = all;
                Caption = 'Budgeted FA No.';
            }
            field("Maintenance Code"; Rec."Maintenance Code")
            {
                ApplicationArea = all;
                Caption = 'Maintenance Code';
            }
        }
    }
}
