extends Node
class_name GameMetrics

# Game metrics
var customer_patience: float = 100.0
var self_boredom: float = 0.0
var manager_annoyance: float = 0.0
var theft_loss: float = 0.0

# Critical thresholds
const CRITICAL_PATIENCE: float = 20.0
const CRITICAL_BOREDOM: float = 80.0
const CRITICAL_ANNOYANCE: float = 80.0
const CRITICAL_THEFT: float = 50.0

# Signal for metric changes
signal metrics_changed

func _ready():
    # Initialize metrics
    reset_metrics()

func reset_metrics():
    customer_patience = 100.0
    self_boredom = 0.0
    manager_annoyance = 0.0
    theft_loss = 0.0
    emit_signal("metrics_changed")

func apply_effects(effects: Dictionary):
    # Apply effects to metrics
    if effects.has("customer_patience"):
        customer_patience = clamp(customer_patience + effects["customer_patience"], 0.0, 100.0)
    
    if effects.has("self_boredom"):
        self_boredom = clamp(self_boredom + effects["self_boredom"], 0.0, 100.0)
    
    if effects.has("manager_annoyance"):
        manager_annoyance = clamp(manager_annoyance + effects["manager_annoyance"], 0.0, 100.0)
    
    if effects.has("theft_loss"):
        theft_loss = clamp(theft_loss + effects["theft_loss"], 0.0, 100.0)
    
    # Emit signal for UI updates
    emit_signal("metrics_changed")

func check_critical_levels() -> bool:
    # Check if any metrics have reached critical levels
    if customer_patience <= CRITICAL_PATIENCE:
        return true
    
    if self_boredom >= CRITICAL_BOREDOM:
        return true
    
    if manager_annoyance >= CRITICAL_ANNOYANCE:
        return true
    
    if theft_loss >= CRITICAL_THEFT:
        return true
    
    return false

func get_metrics_data() -> Dictionary:
    # Return all metrics as a dictionary
    return {
        "customer_patience": customer_patience,
        "self_boredom": self_boredom,
        "manager_annoyance": manager_annoyance,
        "theft_loss": theft_loss
    }
