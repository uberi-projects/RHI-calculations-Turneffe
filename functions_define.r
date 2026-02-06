# functions_define.r

# Define function to assign cover weighted presence for individual benthic observations ---------------------------
#- primary : The column storing primary organism code
#- secondary : The column storing secondary organism code
#- type : The type of organism to calculate weighted presence for
calculate_type_presence <- function(primary, secondary, type) {
    if (!is.na(primary) && primary == type && is.na(secondary)) {
        return(1)
    } else if (!is.na(primary) && !is.na(secondary) && primary == type && secondary == type) {
        return(1)
    } else if ((!is.na(primary) && primary == type) || (!is.na(secondary) && secondary == type)) {
        return(0.5)
    } else {
        return(0)
    }
}
