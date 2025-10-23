variable "name" {
  description = "Nombre del presupuesto"
  type        = string
}

variable "budget_type" {
  description = "Tipo de presupuesto (COST, USAGE, RI_UTILIZATION)"
  type        = string
  default     = "COST"
}

variable "limit_amount" {
  description = "Monto límite del presupuesto"
  type        = number
}

variable "limit_unit" {
  description = "Unidad del límite (USD)"
  type        = string
  default     = "USD"
}

variable "time_unit" {
  description = "Periodo del presupuesto (MONTHLY, DAILY, etc.)"
  type        = string
  default     = "MONTHLY"
}

variable "comparison_operator" {
  description = "Operador de comparación para la notificación"
  type        = string
  default     = "GREATER_THAN"
}

variable "threshold" {
  description = "Porcentaje o cantidad para activar la notificación"
  type        = number
  default     = 80
}

variable "threshold_type" {
  description = "Tipo de umbral (PERCENTAGE o ABSOLUTE_VALUE)"
  type        = string
  default     = "PERCENTAGE"
}

variable "notification_type" {
  description = "Tipo de notificación (ACTUAL o FORECASTED)"
  type        = string
  default     = "ACTUAL"
}

variable "sns_topic_name" {
  description = "Nombre del SNS topic"
  type        = string
  default     = "budget-alerts"
}

variable "email" {
  description = "Correo electrónico para recibir alertas"
  type        = string
}
