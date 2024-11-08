pageextension 60120 "Sales Return Order Ext" extends "Sales Return Order"
{
    actions
    {
        addbefore(CopyDocument)
        {
            action("View Return-Related &Documents")
            {
                ApplicationArea = SalesReturnOrder;
                Caption = 'View Return-Related &Documents';
                Ellipsis = true;
                Image = ApplyEntries;
                ToolTip = 'View related documents, such as a replacement sales order, a purchase return order, or a replacement purchase order.';

                trigger OnAction()
                begin
                    //Clear(CreateRetRelDocs);
                    //CreateRetRelDocs.SetSalesHeader(Rec);
                    //CreateRetRelDocs.RunModal();
                    //CreateRetRelDocs.ShowDocuments();
                    ShowDocuments();
                end;
            }
        }
    }
    var //CreateRetRelDocs: Report "Create Ret.-Related Documents";
 TempRetRelDoc: Record "Returns-Related Document" temporary;
    procedure ShowDocuments()
    begin
        if TempRetRelDoc.FindFirst()then PAGE.Run(PAGE::"Returns-Related Documents", TempRetRelDoc);
    end;
}
