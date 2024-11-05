tableextension 60105 "Sales Header Archive Ext" extends "Sales Header Archive"
{
    fields
    {
        field(60100; "Job No."; Code[20])
        {
            Caption = 'Project No.';
            Editable = false;
            TableRelation = Job;
            FieldClass = FlowField;
            //CalcFormula = Lookup(Job."No." WHERE("Bill-to Customer No." = FIELD("Bill-to Customer No."),
            //"Ship-to Code" = FIELD("Ship-to Code"), "Location Code" = FIELD("Location Code")));
            //CalcFormula = Lookup(Job."No." WHERE("Bill-to Customer No."=FIELD("Bill-to Customer No."), "Ship-to Code"=FIELD("Ship-to Code"), "Loc Code Temp"=FIELD("Location Code")));
            CalcFormula = lookup("Sales Line Archive"."Job No." where("Document Type"=field("Document Type"), "Document No."=field("No."), "Doc. No. Occurrence"=field("Doc. No. Occurrence"), "Version No."=field("Version No."), "Job No."=filter(<>''))); //2024-09-11
        }
        field(60110; "Job Required"; boolean)
        {
            Caption = 'Project Required';
            DataClassification = ToBeClassified;
        }
        field(60120; "Job Type";enum "Job Type")
        {
            caption = 'Project Type';
            DataClassification = ToBeClassified;
        }
    }
}
