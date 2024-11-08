tableextension 60101 "Jobs Setup Ext" extends "Jobs Setup"
{
    fields
    {
        field(60100; "Default Task No."; Code[20])
        {
            Caption = 'Default Task No.';
            DataClassification = ToBeClassified;
        }
        field(60110; "Default Job No.";enum "Default Job No.")
        {
            Caption = 'Default Job No.';
            DataClassification = ToBeClassified;
        }
        field(60120; "Default Job Status";enum "Job Status")
        {
            Caption = 'Default Job Staus';
            DataClassification = ToBeClassified;
        }
    }
}
