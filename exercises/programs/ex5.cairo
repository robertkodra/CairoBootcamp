// Implement a funcion that returns:
// - 1 when magnitudes of inputs are equal
// - 0 otherwise
%builtins range_check

from starkware.cairo.common.math import abs_value

func abs_eq{range_check_ptr}(x: felt, y: felt) -> (bit: felt) {
    let x_abs = abs_value(x);
    let y_abs = abs_value(y);
    if (x_abs - y_abs == 0) {
        return (bit=1);
    }
    return (bit=0);
}
