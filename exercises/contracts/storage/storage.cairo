// Task:
// Develop logic of set balance and get balance methods
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_nn
from openzeppelin.access.ownable.library import Ownable


// Define a storage variable.
@storage_var
func balance() -> (res: felt) {
}


@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr} (owner: felt) {
    Ownable.initializer(owner);
    return();
}

// Returns the current balance.
@view
func get_balance{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() -> (res: felt) {
    let (value) = balance.read();
    return (res=value);
}

// Sets the balance to amount
@external
func set_balance{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(amount: felt) {
    balance.write(amount);
    return();
}
