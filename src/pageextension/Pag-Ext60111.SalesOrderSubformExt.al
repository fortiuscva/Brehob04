pageextension 60111 "Sales Order Subform Ext" extends "Sales Order Subform"
{
    layout
    {
        modify(Type)
        {
            ApplicationArea = All;
        }
        modify("Work Type Code")
        {
            ApplicationArea = All;
            Visible = true;
        }
        addbefore("Location Code")
        {
            field(Rental; rec.Rental)
            {
                caption = 'Rental';
                ToolTip = 'Specifies whether or not the resource is a rental.';
                ApplicationArea = All;
            }
        }
        addafter("Amount Including VAT")
        {
            field("Rental Start Date"; rec."Rental Start Date")
            {
                caption = 'Rental Start Date';
                Tooltip = 'Specifies the start date of a rental resource period.';
                ApplicationArea = all;
            }
            field("Rental End Date"; rec."Rental End Date")
            {
                caption = 'Rental End Date';
                Tooltip = 'Specifies the end date of a rental resource period.';
                ApplicationArea = all;
            }
            /*
            field("Rental Days"; rec."Rental Days")
            {
                caption = 'Rental Days';
                Tooltip = 'Specifies the number of days the resource will be on rent.';
                ApplicationArea = all;
            }
            */
            field("On Rent"; rec."On Rent")
            {
                caption = 'On Rent';
                Tooltip = 'Specifies if the rental resource is currently on rent.';
                ApplicationArea = all;
            }
        }
    }
}
