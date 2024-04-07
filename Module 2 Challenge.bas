Attribute VB_Name = "Module1"
Sub Stock()

' Declare Current as a worksheet object variable.
Dim Current As Worksheet

' Loop through all of the worksheets in the active workbook.
For Each Current In ActiveWorkbook.Worksheets
Current.Activate

    'Set variable to hold ticker name
    Dim TickerName As String
    
    'Set variable to hold opeing value
    Dim OpenValue As Double
    
    'Set variable to hold closing value
    Dim CloseValue As Double
    
    'Set variable to hold yearly change
    Dim YearlyChange As Double
    
    'Set variable to hold percent change
    Dim PercentChange As Double
    
    'Set variable to hold volume total and set to zero
    Dim VolumeTotal As LongLong
    VolumeTotal = 0
    
    'Set variable to hold greatest increase
    Dim GreatestIncrease As Double
    GreatestIncrease = 0
    
    'Set variable to hold greatest increase ticker name
    Dim IncTickerName As String
    
    'Set variable to hold greatest decrease
    Dim GreatestDecrease As Double
    GreatestDecrease = 0
    
    'Set variable to hold greatest decrease ticker name
    Dim DecTickerName As String
    
    'Set variable to hold greatest total volume
    Dim GreatestVolume As LongLong
    GreatestVolume = 0
    
    'Set variable to hold greatest total volume ticker name
    Dim VolTickerName As String
    
    'Track current row on summary table
    Dim SummaryRow As Integer
    SummaryRow = 2
    
    'Count all rows
    lastrow = Cells(Rows.Count, 1).End(xlUp).Row
    
    'Loop through each row
    For I = 2 To lastrow
    
        'Check for initial ticker entry
        If Cells(I - 1, 1).Value <> Cells(I, 1).Value Then
        
            'Set opening value
            OpenValue = Cells(I, 3).Value
            
            'Set ticker name
            TickerName = Cells(I, 1).Value
            
            'Add ticker to summary table
            Cells(SummaryRow, 9) = TickerName
            
        End If
        
        'Check for last ticker entry
        If Cells(I + 1, 1).Value <> Cells(I, 1).Value Then
        
            'Set closing value
            CloseValue = Cells(I, 6)
            
            'Calculate yearly change
            YearlyChange = CloseValue - OpenValue
            
            'Add yearly change to summary table
            Cells(SummaryRow, 10) = YearlyChange
            
            'Checking if yearly change is negative
            If Cells(SummaryRow, 10).Value < 0 Then
                
               'Set fill to red for negative
               Cells(SummaryRow, 10).Interior.ColorIndex = 3
            
            Else 'conditional for non-negative
            
                'Set fill to green
                Cells(SummaryRow, 10).Interior.ColorIndex = 4
                
        
            End If
            
            'Calculate percent change
            PercentChange = YearlyChange / OpenValue
            
            'Add percent change to summary table
            Cells(SummaryRow, 11).Value = FormatPercent(PercentChange)
            
            'Checking for greatest increase
            If PercentChange > GreatestIncrease Then
                
                'Set new greatest increase
                GreatestIncrease = PercentChange
                
                'Set ticker name for greatest increase
                IncTickerName = TickerName
                        
            End If
                            
            'Checking for greatest decrease
            If PercentChange < GreatestDecrease Then
                
                'Set new greatest increase
                GreatestDecrease = PercentChange
                
                'Set ticker name for greatest decrease
                DecTickerName = TickerName
          
            End If
            
            'Add current cell to volume total
            VolumeTotal = VolumeTotal + Cells(I, 7).Value
            
            'Add volume total to summary table
            Cells(SummaryRow, 12).Value = VolumeTotal
            
            'Checking for greatest total volume
            If VolumeTotal > GreatestVolume Then
                
                'Set new greatest volume
                GreatestVolume = VolumeTotal
                
                'Set ticker name for greatest total volume
                VolTickerName = TickerName
                
                
            End If
            
            'Reset volume total for next ticker
            VolumeTotal = 0
            
            'Go to next row on summary table
            SummaryRow = SummaryRow + 1
            
        Else
        
            'Add current cell to volume total
            VolumeTotal = VolumeTotal + Cells(I, 7).Value
        
        End If
               
               
    Next I

    'Add greatest increase ticker name to table
    Cells(2, 16).Value = IncTickerName
                
    'Add greatest increase percent change to table
    Cells(2, 17).Value = FormatPercent(GreatestIncrease)

    'Add greatest decrease ticker name to table
    Cells(3, 16).Value = DecTickerName
                
    'Add greatest decrease percent change to table
    Cells(3, 17).Value = GreatestDecrease

    'Add greatest total volume ticker name to table
    Cells(4, 16).Value = VolTickerName
                
    'Add greatest total volume to table
    Cells(4, 17).Value = GreatestVolume

Next
    
End Sub



