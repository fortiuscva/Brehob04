pageextension 60121 "Req. Worksheet Ext" extends "Req. Worksheet"
{
    layout
    {
        addafter("Replenishment System")
        {
            field("Sales Order No."; rec."Sales Order No.")
            {
                caption = 'Sales Order No.';
                ToolTip = 'Specifies the Sales Order No.';
                ApplicationArea = all;
            }
            field("Sales Order Line No."; rec."Sales Order Line No.")
            {
                caption = 'Sales Order Line No.';
                ToolTip = 'Specifies the Sales Order Line No.';
                ApplicationArea = all;
            }
            field("Sales Order Comment"; rec."Sales Order Comment")
            {
                caption = 'Sales Order Comment';
                Tooltip = 'Specifies if a Sales Line Comment exists';
                ApplicationArea = All;
            }
        }
    }
}
