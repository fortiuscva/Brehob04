tableextension 60113 "Sales Line Archive Ext" extends "Sales Line Archive"
{
    fields
    {
        field(60110; Rental; Boolean)
        {
            caption = 'Rental';
            DataClassification = ToBeClassified;
        }
        field(60115; "Rental Start Date"; date)
        {
            caption = 'Rental Start Date';
            DataClassification = ToBeClassified;
        }
        field(60120; "Rental End Date"; date)
        {
            caption = 'Rental End Date';
            DataClassification = ToBeClassified;
        }
        field(60150; "On Rent"; boolean)
        {
            caption = 'On Rent';
            DataClassification = ToBeClassified;
        }
        field(60155; "Resource Type"; Enum "Resource Type")
        {
            caption = 'Resource Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60160; Freight; Boolean)
        {
            caption = 'Freight';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
