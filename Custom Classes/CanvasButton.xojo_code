#tag Class
Protected Class CanvasButton
Inherits DesktopCanvas
	#tag Event
		Sub FocusLost()
		  If Enabled And AllowFocusRing Then
		    IsFocused = False
		    Refresh(False)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub FocusReceived()
		  // Only if the button is enabled
		  If Enabled And AllowFocusRing Then
		    IsFocused = True
		    // Redraw so that your Paint event can draw a focus ring
		    Refresh(False)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  #Pragma unused x
		  #Pragma unused y
		  
		  // Only process if the button is enabled.
		  If Enabled Then
		    // Set internal state to indicate the button is being pressed.
		    IsPressed = True
		    SetFocus
		    // Refresh the control to show the pressed state visually.
		    Refresh(False)
		    // Return True to indicate that this event was handled.
		    Return True
		  Else
		    // If disabled, do not handle the event.
		    Return False
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  // Only process if the button is enabled.
		  If Enabled Then
		    // Set internal state to indicate the mouse is hovering over the button.
		    IsHovered = True
		    // Refresh the control to show the hover state visually.
		    Refresh(False)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  // Only process if the button is enabled.
		  If Enabled Then
		    // Set internal state to indicate the mouse is no longer hovering.
		    IsHovered = False
		    // Reset pressed state if mouse leaves while pressed (prevents accidental clicks).
		    IsPressed = False
		    // Refresh the control to revert from the hover state.
		    Refresh(False)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  #Pragma unused x
		  #Pragma unused y
		  
		  // Only process if the button is enabled.
		  If Enabled Then
		    // Check if the button was pressed down AND the mouse is still hovering over it.
		    If IsPressed And IsHovered Then
		      // If true, the button was successfully clicked. Raise the custom Pressed event.
		      RaiseEvent Pressed
		    End If
		    // Reset the pressed state regardless of whether the click was successful.
		    IsPressed = False
		    // Refresh the control to revert from the pressed state.
		    Refresh(False)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma unused areas
		  
		  // Use the custom CornerRadius property.
		  Var currentCornerRadius As Integer = CornerRadius
		  
		  // Declare variables for the colors used in drawing.
		  Var currentBgColor As Color
		  Var currentBorderColor As Color
		  Var currentTextColor As Color
		  
		  // Determine colors based on the button's current state (enabled, pressed, hovered).
		  If Enabled Then
		    If IsPressed Then
		      // Use highlight color if pressed.
		      currentBgColor = HighlightColor
		      currentBorderColor = BorderColor
		      currentTextColor = TextColor
		    ElseIf IsHovered Then // Check for hover only if not pressed
		      // Use hover color if hovered.
		      currentBgColor = HoverColor
		      currentBorderColor = BorderColor
		      currentTextColor = TextColor
		    Else
		      // Use the custom background color for the default state.
		      currentBgColor = BackgroundColor
		      currentBorderColor = BorderColor
		      currentTextColor = TextColor
		    End If
		  Else
		    // Use appropriate system or standard gray colors for the disabled state.
		    currentBgColor = Color.LightGray
		    currentBorderColor = Color.Gray
		    currentTextColor = Color.DisabledTextColor // Use system disabled text color
		  End If
		  
		  // Set the drawing color and draw the background shape with rounded corners.
		  g.DrawingColor = currentBgColor
		  g.FillRoundRectangle(0, 0, g.Width, g.Height, currentCornerRadius, currentCornerRadius)
		  
		  // Set the drawing color and pen size for the border.
		  g.DrawingColor = currentBorderColor
		  g.PenSize = 2
		  // Draw the border shape just inside the background rectangle.
		  g.DrawRoundRectangle(0, 0, g.Width, g.Height, currentCornerRadius, currentCornerRadius)
		  
		  // Draw the focus ring
		  If IsFocused And AllowFocusRing Then
		    g.DrawingColor = Color.HighlightColor
		    g.PenSize = 1
		    g.DrawRoundRectangle(2, 2, g.Width-4, g.Height-4, CornerRadius-2, CornerRadius-2)
		  End If
		  
		  // Enable anti-aliasing for smoother text rendering.
		  g.AntiAliasMode = Graphics.AntiAliasModes.HighQuality
		  g.AntiAliased = True
		  // Calculate the width and height of the button text.
		  Var tw As Double = g.TextWidth(ButtonText)
		  Var th As Double = g.TextHeight
		  // Calculate the X position to center the text horizontally.
		  // Updated: compute X based on TextAlignment (Left, Center, Right) while preserving centered behavior as default.
		  Var tx As Double
		  Select Case TextAlignment
		  Case TextAlign.Left
		    tx = TextPadding
		  Case TextAlign.Right
		    tx = g.Width - tw - TextPadding
		  Case TextAlign.Center
		    tx = (g.Width - tw) / 2
		  End Select
		  // Calculate the Y position to center the text vertically, with a small adjustment.
		  Var ty As Double = (g.Height + th) / 2 - 3
		  // Set the drawing color for the text.
		  g.DrawingColor = currentTextColor
		  // Draw the button text at the calculated centered position.
		  g.DrawText(ButtonText, tx, ty)
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0, Description = 54686973206576656E7420697320726169736564207768656E2074686520627574746F6E20697320636C69636B656420284D6F7573655570206F6363757273207768696C65207072657373656420616E6420686F7665726564292E
		Event Pressed()
	#tag EndHook


	#tag Property, Flags = &h0
		BackgroundColor As Color = &c5e2d8b
	#tag EndProperty

	#tag Property, Flags = &h0
		BorderColor As Color = &c525252
	#tag EndProperty

	#tag Property, Flags = &h0
		ButtonText As String = "Click Me"
	#tag EndProperty

	#tag Property, Flags = &h0
		CornerRadius As Integer = 4
	#tag EndProperty

	#tag Property, Flags = &h0
		HighlightColor As Color = &c628eff
	#tag EndProperty

	#tag Property, Flags = &h0
		HoverColor As Color = &c729fcf
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IsFocused As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IsHovered As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IsPressed As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		TextAlignment As TextAlign = TextAlign.Center
	#tag EndProperty

	#tag Property, Flags = &h0
		TextColor As Color = &ceeeeee
	#tag EndProperty

	#tag Property, Flags = &h0
		TextPadding As Integer = 8
	#tag EndProperty


	#tag Enum, Name = TextAlign, Type = Integer, Flags = &h0
		Left
		  Center
		Right
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="80"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="22"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonText"
			Visible=true
			Group="Appearance"
			InitialValue="Click Me"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextAlignment"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="TextAlign"
			EditorType="Enum"
			#tag EnumValues
				"0 - Left"
				"1 - Center"
				"2 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextPadding"
			Visible=true
			Group="Appearance"
			InitialValue="8"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CornerRadius"
			Visible=true
			Group="Appearance"
			InitialValue="4"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="Button Colors"
			InitialValue="&c5e2d8b"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverColor"
			Visible=true
			Group="Button Colors"
			InitialValue="&c729fcf"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderColor"
			Visible=true
			Group="Button Colors"
			InitialValue="&c525252"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextColor"
			Visible=true
			Group="Button Colors"
			InitialValue="&ceeeeee"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HighlightColor"
			Visible=true
			Group="Button Colors"
			InitialValue="&c628eff"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=false
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
