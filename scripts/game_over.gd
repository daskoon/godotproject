extends Control

func _ready():
    # Connect button signal
    $ReturnButton.connect("pressed", self, "_on_return_button_pressed")
    
    # Display results
    display_results()

func _on_return_button_pressed():
    # Return to main menu
    get_tree().change_scene("res://scenes/MainMenu.tscn")

func display_results():
    # Get metrics from GameManager
    var metrics = GameManager.metrics.get_metrics_data()
    
    # Evaluate performance
    var result_text = "Shift Results:\n\n"
    
    # Customer Patience
    if metrics.customer_patience >= 80:
        result_text += "Customer Satisfaction: Excellent\n"
    elif metrics.customer_patience >= 50:
        result_text += "Customer Satisfaction: Good\n"
    elif metrics.customer_patience >= 30:
        result_text += "Customer Satisfaction: Poor\n"
    else:
        result_text += "Customer Satisfaction: Terrible\n"
    
    # Self Boredom
    if metrics.self_boredom <= 30:
        result_text += "Your Engagement: Excellent\n"
    elif metrics.self_boredom <= 60:
        result_text += "Your Engagement: Good\n"
    elif metrics.self_boredom <= 80:
        result_text += "Your Engagement: Poor\n"
    else:
        result_text += "Your Engagement: Terrible\n"
    
    # Manager Annoyance
    if metrics.manager_annoyance <= 30:
        result_text += "Manager's Opinion: Excellent\n"
    elif metrics.manager_annoyance <= 60:
        result_text += "Manager's Opinion: Good\n"
    elif metrics.manager_annoyance <= 80:
        result_text += "Manager's Opinion: Poor\n"
    else:
        result_text += "Manager's Opinion: Terrible\n"
    
    # Theft Loss
    if metrics.theft_loss <= 20:
        result_text += "Security Performance: Excellent\n"
    elif metrics.theft_loss <= 40:
        result_text += "Security Performance: Good\n"
    elif metrics.theft_loss <= 60:
        result_text += "Security Performance: Poor\n"
    else:
        result_text += "Security Performance: Terrible\n"
    
    # Overall result
    var average_score = (metrics.customer_patience + (100 - metrics.self_boredom) + 
                         (100 - metrics.manager_annoyance) + (100 - metrics.theft_loss)) / 4
    
    result_text += "\nOverall Performance: "
    
    if average_score >= 80:
        result_text += "Excellent! You're a natural at this job."
    elif average_score >= 60:
        result_text += "Good. You're getting the hang of it."
    elif average_score >= 40:
        result_text += "Mediocre. You need more practice."
    else:
        result_text += "Poor. This might not be the job for you."
    
    # Update the label
    $ResultsLabel.text = result_text
