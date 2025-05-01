#tag Class
Protected Class CanvasButton
Inherits DesktopCanvas
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  // Set internal state to indicate the button is being pressed.
		  IsPressed = True
		  // Refresh the control to show the pressed state visually.
		  Me.Refresh(False)
		  // Return True to indicate that this event was handled.
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  // Set internal state to indicate the mouse is hovering over the button.
		  IsHovered = True
		  // Refresh the control to show the hover state visually.
		  Me.Refresh(False)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  // Set internal state to indicate the mouse is no longer hovering.
		  IsHovered = False
		  // Refresh the control to revert from the hover state.
		  Me.Refresh(False)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  // Check if the button was pressed down AND the mouse is still hovering over it.
		  If IsPressed And IsHovered Then
		    // If true, the button was successfully clicked. Raise the custom Pressed event.
		    RaiseEvent Pressed
		  End If
		  // Reset the pressed state regardless of whether the click was successful.
		  IsPressed = False
		  // Refresh the control to revert from the pressed state.
		  Me.Refresh(False)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  // Corner radius of the button shape.
		  Static CornerRadius As Integer = 4
		  
		  // Declare variables for the colors used in drawing.
		  Var bgColor As Color
		  Var borderColor As Color = Color.DarkBevelColor
		  Var TextColor As Color = Color.LightTingeColor
		  
		  // Determine the background color based on the button's current state (pressed or hovered).
		  If IsPressed Or IsHovered Then
		    // Use a highlight color if pressed or hovered.
		    bgColor = Color.HighlightColor
		  Else
		    // Use the accent theme color for the default state.
		    bgColor = Color.AccentThemeColor
		  End If
		  
		  // Set the drawing color and draw the background shape with rounded corners.
		  g.DrawingColor = bgColor
		  g.FillRoundRectangle(0, 0, g.Width, g.Height, CornerRadius, CornerRadius)
		  
		  // Set the drawing color and pen size for the border.
		  g.DrawingColor = borderColor
		  g.PenSize = 2
		  // Draw the border shape just inside the background rectangle.
		  g.DrawRoundRectangle(1, 1, g.Width-2, g.Height-2, CornerRadius, CornerRadius)
		  
		  // Enable anti-aliasing for smoother text rendering.
		  g.AntiAliasMode = Graphics.AntiAliasModes.HighQuality
		  g.AntiAliased = True
		  // Calculate the width and height of the button text.
		  Var tw As Double = g.TextWidth(ButtonText)
		  Var th As Double = g.TextHeight
		  // Calculate the X position to center the text horizontally.
		  Var tx As Double = (g.Width - tw) / 2
		  // Calculate the Y position to center the text vertically, with a small adjustment.
		  Var ty As Double = (g.Height + th) / 2 - 3
		  // Set the drawing color for the text.
		  g.DrawingColor = TextColor
		  // Draw the button text at the calculated centered position.
		  g.DrawText(ButtonText, tx, ty)
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0, Description = 54686973206576656E7420697320726169736564207768656E2074686520627574746F6E20697320636C69636B656420284D6F7573655570206F6363757273207768696C65207072657373656420616E6420686F7665726564292E
		Event Pressed()
	#tag EndHook


	#tag Property, Flags = &h0
		ButtonText As String = "Click Me"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IsHovered As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IsPressed As Boolean = False
	#tag EndProperty


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
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
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
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="False"
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
