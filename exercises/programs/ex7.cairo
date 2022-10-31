%lang starknet
from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import unsigned_div_rem

// Using binary operations return:
// - 1 when pattern of bits is 01010101 from LSB up to MSB 1, but accounts for trailing zeros
// - 0 otherwise

// 000000101010101 PASS
// 010101010101011 FAIL

func pattern{bitwise_ptr: BitwiseBuiltin*, range_check_ptr}(
    n: felt, idx: felt, exp: felt, broken_chain: felt
) -> (true: felt) {

    let(state) = checkBinaryNumber(n, idx, exp);

    //%{ print(f"State of Value {ids.n} : {ids.state}") %}

    return (true=state);
}

func checkBinaryNumber{bitwise_ptr: BitwiseBuiltin*, range_check_ptr}(n: felt, idx: felt, exp: felt) -> (state: felt) {
    if (n == 0) {
        // check MSB = 1
        if (exp == 1) {
            return (state = 1);
        } else {
            return (state = 0);
        }
    }

    let(q, r) = unsigned_div_rem(n, 2);

    // store in memory the first bit
    if (idx == 0) {
        let (res) = checkBinaryNumber(n=q, idx=idx+1, exp = r);
        return (state = res);
    } 
    // if new_bit = last_bit => error
    if (r == exp) {
        return (state = 0);
    } else {
        let (res) = checkBinaryNumber(n=q, idx=idx+1, exp = r);
        return (state = res);
    }
}

