tableextension 60104 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(60100; "Job No."; Code[20])
        {
            Caption = 'Project No.';
            Editable = false;
            TableRelation = Job;
            FieldClass = FlowField;
            //CalcFormula = Lookup(Job."No." WHERE("Bill-to Customer No." = FIELD("Bill-to Customer No."), "Ship-to Code" = FIELD("Ship-to Code"), "Loc Code Temp" = FIELD("Location Code")));
            CalcFormula = lookup("Sales Invoice Line"."Job No." where("Document No."=field("No."), "Job No."=filter(<>''))); //2024-09-11
        }
        field(60110; "Job Required"; Boolean)
        {
            Caption = 'Project Required';
            DataClassification = ToBeClassified;
        }
        field(60120; "Job Type";enum "Job Type")
        {
            caption = 'Project Type';
            DataClassification = ToBeClassified;
        }
        field(60140; "Completion Date"; date)
        {
            caption = 'Completion Date';
            DataClassification = ToBeClassified;
        }
    }
}
