tableextension 60116 "Requisition Line Ext" extends "Requisition Line"
{
    fields
    {
        field(60100; "Sales Order Comment"; Boolean)
        {
            Caption = 'Sales Order Comment';
            //DataClassification = ToBeClassified;
            FieldClass = flowfield;
            CalcFormula = exist("Sales Comment Line" where("Document Line No."=field("Sales Order Line No."), "No."=field("Sales Order No.")));
        }
    }
}
