tableextension 60122 "Customer Ext" extends Customer
{
    fields
    {
        field(60200; "P.O. Required"; Boolean)
        {
            Caption = 'P.O. Required';
            DataClassification = ToBeClassified;
        }
    }
}
