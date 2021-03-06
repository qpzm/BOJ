# frozen_string_literal: true

# O(nlogk) where k is the length of lis
INT_MIN = -1_000_000_001
INT_MAX = 1_000_000_001

def lis_len(arr, size)
  len_arr = [INT_MIN] * size
  candidate = [INT_MIN] + [INT_MAX] * size
  arr.each_with_index do |elem, i|
    # bsearch_index는 해당 block이 true를 return하는 가장 작은 인덱스를 반환
    # strictly increasing 이므로 같은 것이 있으면 그 오른쪽에 놓으면 안 됨
    j = candidate.bsearch_index { |x| elem <= x }
    candidate[j] = elem if candidate[j] > elem
    len_arr[i] = j
  end
  len_arr
end

def find_lis(arr, len_arr, idx)
  return [arr[idx]] if len_arr[idx] == 1

  (idx - 1).downto(0).each do |i|
    if len_arr[i] == len_arr[idx] - 1 && arr[i] < arr[idx]
      return find_lis(arr, len_arr , i) + [arr[idx]]
    end
  end
end

def format_result(arr, len_arr)
  max_len, max_idx = INT_MIN, 0
  len_arr.each_with_index do |e, i|
    max_len, max_idx = e, i if max_len < e
  end
  return max_len, find_lis(arr, len_arr, max_idx).join(' ')
end

if __FILE__ == $0
  n = gets.to_i
  arr = gets.split.map(&:to_i)
  len_arr = lis_len(arr, n)
  puts format_result(arr, len_arr)
end
