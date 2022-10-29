from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

// Implement a function that sums even numbers from the provided array
func sum_even{bitwise_ptr: BitwiseBuiltin*}(arr_len: felt, arr: felt*, run: felt, idx: felt) -> (
    sum: felt
) {
    if (arr_len == 0) {
        return (sum=0);
    }

    //let (_,res) = unsigned_div_rem([arr], 2);
    let (res) = bitwise_xor([arr], 1);
    if (res == [arr] + 1) {
        let (res) = sum_even(arr_len = arr_len-1, arr=arr+1, run=run+1, idx=idx+1);
        return (sum = [arr] + res);
    } else {
        let (res) = sum_even(arr_len = arr_len-1, arr=arr+1, run=run+1, idx=idx+1);
        return (sum = res);
    }
}
