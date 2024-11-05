pageextension 60108 "Resource Groups Ext" extends "Resource Groups"
{
    layout
    {
        addafter(Name)
        {
            field(Rental; rec.Rental)
            {
                caption = 'Rental';
                ToolTip = 'Specifies whether the Resource Group is associated with Rentals.';
                ApplicationArea = All;
            }
        }
    }
}
