#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

int inputCheck();
void menue(int choice);
void differs_in_n_chars(char s1[], char s2[], int n);
int printStrings(int n);
void abc(char arr[], int len, int curr, int*n);
void max_set(int arr[], int size);
void recScanf(int *arr[], int size, int curr);
int *lenth(int arr[], int size, int len, int i, int iMax, int *maxLen);
void n_queens(int board[10][10], int size, int solution_num);
void collumsCheck(int board[10][10], int size, int rows, int cols, int n);
int collIsClear(int board[10][10], int size, int rows, int cols);
int rowsCheck(int board[10][10], int size, int rows, int cols);
int isAvailable(int arr[10][10], int size, int rows, int cols);
int mooveQueen(int board[10][10], int size, int rows, int cols);
void printBoard(int board[10][10], int size, int rows, int cols);
void printRow(int board[10][10], int size, int rows, int cols);

void main()
{//behold, the shortest main in history.
	menue(inputCheck());	
}
int inputCheck()
{
	int choice;
	printf("enter a question number or 0 for exit\n");
	scanf("%d", &choice);
	if (choice < 0 || choice>4)
	{
		printf("the entered number should be between 0 and 4\n");
		return inputCheck();
	}
	return choice;
}
void menue(int choice)
{
	int n, num, arr[50], size, curr = 0, solution_num, arr1[10][10] = { { 0 } };
	char s1[50], s2[50], a[12];
	switch (choice)
	{
	case 0:
		return;
	case 1:
		gets(a);//clear ant buffer garbage from scanf.
		printf("enter the first string\n");
		gets(s1);
		printf("enter the second string\n");
		gets(s2);
		printf("enter the number of different chars\n");
		scanf("%d", &n);
		differs_in_n_chars(s1, s2, n);
		return menue(inputCheck());
	case 2:
		printf("enter the wanted size\n");
		scanf("%d", &n);
		printf("%d\n", printStrings(n));
		return menue(inputCheck());
	case 3:
		printf("enter the array size\n");
		scanf("%d", &size);
		recScanf(&arr, size, curr);
		max_set(arr, size);
		return menue(inputCheck());
	case 4:
		printf("enter the size of the board\n");
		scanf("%d", &size);
		printf("enter the number of the requested solution\n");
		scanf("%d", &solution_num);
		n_queens(arr1, size, solution_num);
		printBoard(arr1, size, 0, 0);
		return menue(inputCheck());
	}
}
void differs_in_n_chars(char s1[], char s2[], int n)
{//the function decrease 1 from n each time the chars in s1 different from the char in s2.
	if (n < 0 )//means there are too many different chars.
	{
		printf("0\n");
		return;
	}
	if (s1[0] != '\0' && s2[0] != '\0')
	{
		if (s1[0] == s2[0])
			return differs_in_n_chars(s1 + 1, s2 + 1, n );//the chars are equal, continue.
		return differs_in_n_chars(s1 + 1, s2 + 1, n-1);//the chars are different, decrease 1.
	}
	if (s1[0] == '\0')//means its the end of s1.
		n -= strlen(s2);//all of the other chars remain in s2 are differents than s1.
	if (s2[0] == '\0')//same as above.
		n -= strlen(s1);
	if (n == 0)//means success .
	{
		printf("1\n");
		return;
	}
	printf("0\n");//means n>0
	return;
}
int printStrings(int n)
{
	int len = n, curr = 0, numOfArr = 0;
	char arr[10];
	abc(arr, len, curr, &numOfArr);
	return numOfArr;
}
void abc(char arr[], int len, int curr, int*n)
{
	if (len == curr)//means we have reached the wanted lenth.
	{
		arr[len] = '\0';//so that the %s will stop at the end of the string we want him to print.
		printf("%s,", arr);
		(*n) += 1;//the value n points to is numOfArr, than after we have found a solution, we need to increase him by 1.
		return;
	}
	if (arr[curr - 1] != 'A')//because we don't want 2 A's in a row.
	{
		arr[curr] = 'A';
		abc(arr, len, curr + 1, n);
	}
	arr[curr] = 'B';
	abc(arr, len, curr + 1, n);
	if (!(arr[curr - 1] == 'C'&&arr[curr - 2] == 'C'))//because we don't want 3 C's in a row.
	{
		arr[curr] = 'C';
		abc(arr, len, curr + 1, n);
	}
}
void max_set(int arr[], int size)
{
	int len = 1, i = 1, iMax = 0, maxLen = 1;

	printf("%d\n", *lenth(arr, size - 1, len, i, iMax, &maxLen));
}
void recScanf(int *arr[], int size, int curr)
{
	if (size == 0)
		return;
	printf("enter the element at the %d index\n", curr++);
	scanf("%d", arr);
	recScanf(arr + 1, size - 1, curr);
}
int *lenth(int arr[], int size, int len, int i, int iMax, int *maxLen)
{
	int temp;
	if (size == 0)
	{
		*maxLen = len > *maxLen ? len : *maxLen;//checks if we got a higher lenth in this iteration.
		return maxLen;
	}
	lenth(arr, size - 1, len, i + 1, iMax, maxLen);//skips the maximum check.
	if (arr[i] > arr[iMax])//maximum check.
	{
		iMax = i;//update the max index.
		lenth(arr, size - 1, len + 1, i + 1, iMax, maxLen);//we have found a higher number, so we increase the lenth of the series,
	}
	else
		lenth(arr, size - 1, len, i + 1, iMax, maxLen);//because we didn't found a higher number, we move on to check the nuxt number without increasing the lenth.
	lenth(arr + 1, size - 1, 1, 1, 0, maxLen);//starts over the function frome the next number.
}
void n_queens(int board[10][10], int size, int solution_num)
{
	collumsCheck(board, size, 0, 0, solution_num);
	return;
}
void collumsCheck(int board[10][10], int size, int rows, int cols, int n)
{
	int c;
	if (cols < 0)
		return;
	if (cols == size)//then there are no more queens to put on the board.
	{
		n = n - 1;//we have found a solution, so we decrease the solution number.
		if (n == 0)//then we have found the wanted solution number.
			return;
		else  collumsCheck(board, size, 0, cols - 1, n);// then we still haven't found the wanted solution number.
	}
	else if (collIsClear(board, size, rows, cols))//then its the first time we enterd this column or we came back from move q
	{
		if (rowsCheck(board, size, rows, cols))//returns 1 if we've successfully placed a queen in the current column, 0 if not.
			collumsCheck(board, size, rows, cols + 1, n);//move on to the next column.
		else collumsCheck(board, size, rows, cols - 1, n);//if we couldn't placed a queen, we need to go bace to the previous
	}                                                     // column and move the queen to the next leagle place
	else
	{
		c = mooveQueen(board, size, 0, cols);//returns the column index we starts the next iteration according to what find queen returns.
		collumsCheck(board, size, 0, c, n);
	}
}
int collIsClear(int board[10][10], int size, int rows, int cols)
{
	if (rows == size)//then the column is clear.
		return 1;
	if (board[rows][cols] == 0)
		return collIsClear(board, size, rows + 1, cols);
	return 0;//then there is a queen in the column.

}
int rowsCheck(int board[10][10], int size, int rows, int cols)
{
	if (rows == size)//then we haven't found a place for a queen.
		return 0;
	if (isAvailable(board, size, rows, cols))//checks if the current place is valid. 
	{
		board[rows][cols] = 1;
		return 1;//return 1 because we have managed to place a queen.
	}
	return rowsCheck(board, size, rows + 1, cols);//checks if the next place in the current column is valid.
}
int isAvailable(int arr[10][10], int size, int rows, int cols)
{//return 1 if the spot is not threatned, 0 if it is
	int i, j, in, jn, flag = 1;
	for (i = in = rows, j = jn = cols; flag; )
	{
		if (i < size)
		{
			if (arr[i][cols])//coll down
				return 0;
			if (j < size)
				if (arr[i][j])//right down
					return 0;
			if (jn >= 0)
				if (arr[i][jn])//left down
					return 0;
			i++;
		}
		if (j < size)
		{
			if (arr[rows][j])//row right
				return 0;
			if (in >= 0)
				if (arr[in][j])//right up
					return 0;
			j++;
		}
		if (in >= 0)
		{
			if (arr[in][cols])//coll up
				return 0;
			if (jn >= 0)
				if (arr[in][jn])//left up
					return 0;
			in--;
		}
		if (jn >= 0)
		{
			if (arr[rows][jn])//row left
				return 0;
			jn--;
		}

		if ((i == size) && (j == size) && (in == -1) && (jn == -1))//then there are no more threats.
			flag = 0;
	}
	return 1;//means the place is legit.
}
int mooveQueen(int board[10][10], int size, int rows, int cols)
{
	if (rows == size)//then we couldn't find a legit place for the queen at the rest of the column.
		return cols - 1;//we need to move the queen at the previos column.
	if (board[rows][cols] == 1)//then we have found the queen.
	{
		board[rows][cols] = 0;
		if (rowsCheck(board, size, rows + 1, cols))//if we managed to placed the queen.
			return cols + 1;//move on to the next column.
		else return cols - 1;//go bace to the previos column.
	}
	else return mooveQueen(board, size, rows + 1, cols);//look for the queen in the next place.
}
void printBoard(int board[10][10], int size, int rows, int cols)
{
	if (rows == size)
		return;
	printRow(board, size, rows, 0);
	printBoard(board, size, rows + 1, 0);
}
void printRow(int board[10][10], int size, int rows, int cols)
{
	if (cols == size - 1)
	{
		printf("%d\n", board[rows][cols]);
		return;
	}
	printf("%d ", board[rows][cols]);
	printRow(board, size, rows, cols + 1);
}
