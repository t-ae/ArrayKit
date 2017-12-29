
extension Array where Element: Comparable {    
    /// Returns k-th smallest element.
    public func quickSelect(k: Int) -> Element {
        precondition(k < count, "Index out of ramge.")
        var array = self
        
        var left = 0
        var right = array.count
        
        while true {
            if left == k && right == k+1 {
                return array[k]
            }
            
            var l = left
            var r = right - 1
            
            var sep: Int = -1
            
            // pick pivot randomly
            let pivotIndex = randint(right - left) + left
            let pivot = array[pivotIndex]
            
            while true {
                while array[l] < pivot {
                    l += 1
                    if l == r {
                        sep = l
                        break
                    }
                }
                while array[r] >= pivot && l != r {
                    r -= 1
                    if l == r {
                        sep = l
                        break
                    }
                }
                if l == r {
                    break
                }
                
                let temp = array[l]
                array[l] = array[r]
                array[r] = temp
            }
            
            // For all i < sep, array[i] < pivot
            if k < sep {
                right = sep
            } else {
                left = sep
            }
        }
    }
}
