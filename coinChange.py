def userInput():
    
    coins = []
    print("Please enter desired value for each variable")

    sizeOfCoins = int(input("Total Number of Coins(integer): "))
    print("Enter value(integer) for each coins (Press Enter after each value)")
    for i in range(0, sizeOfCoins):
        coinsValue = int(input())
        coins.append(coinsValue)
    
    targetSum = int(input("Target Sum: "))
    
    return(coins, targetSum)


def calculationOfWays(coins, sum):
    noOfWays = [0] * (sum + 1)
    noOfWays[0] = 1
    coinsCombination = [[] for i in range(0, sum + 1)]
    coinsCombination[0].append([])

    for coin in coins:
        for currentSum in range(coin, sum + 1):
            noOfWays[currentSum] += noOfWays[currentSum - coin]
            for prevCombination in coinsCombination[currentSum - coin]:
                coinsCombination[currentSum].append(prevCombination + [coin])

    return noOfWays[sum], coinsCombination[sum]


if __name__ == "__main__":
    coinsList, target = userInput()
    noOfWays, combination = calculationOfWays(coinsList, target)
    print("Total number of ways is ", noOfWays)
    print("The combination: ")
    for combi in combination:
        print(combi)
