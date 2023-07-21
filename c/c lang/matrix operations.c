#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void printMenu();
int getMenu();
void printMatrix(int matrix[][50], int rows, int cols);
void initMatrix(int matrix[][50], int rows, int cols);
void transposeMatrix(int matrix[][50], int oldRows, int oldCols);
void sortByRows(int matrix[50][50], int rows, int cols);
int rowSum(int matrix[50][50], int i, int cols);
void switchRows(int i, int iSumMax, int matrix[50][50], int cols);
void sortMatrix(int matrix[][50], int rows, int cols);
int matrixValue(int matrix[][50], int rows, int cols);
void powMatrix(int matrix[][50], int size, int matPower);
int subMatrixCount(int matrix[][50], int rows, int cols, int sum);
int inputCheck(char num[256]);
int menuCheck(char num[256]);

void main()
{
	int matrix[50][50] = { 0 }, temp, choice, power, rows, cols, sum, bc[12];
	char num[256];
	do
	{
		printf("Insert number of rows (1-50): ");
		gets(num);
		if ( inputCheck(num)==0 )
			printf("Wrong input, try again\n");
		else
			rows = inputCheck(num);
	} while (inputCheck(num)==0);

	do
	{
		printf("Insert number of columns (1-50): ");
        gets(num);
		if (inputCheck(num)==0)
			printf("Wrong input, try again\n");
		else
			cols = inputCheck(num);
	} while (inputCheck(num) == 0);

	do
	{
		choice = getMenu();
		switch (choice)
		{
		case 0:
			break;
		case 1:
			printMatrix(matrix, rows, cols);
			break;
		case 2:
			initMatrix(matrix, rows, cols);
			break;
		case 3:
			transposeMatrix(matrix, rows, cols);
			temp = rows;
			rows = cols;
			cols = temp;
			break;
		case 4:
			sortByRows(matrix, rows, cols);
			break;
		case 5:
			sortMatrix(matrix, rows, cols);
			break;
		case 6:
			printf("%d\n", matrixValue(matrix, rows, cols));
			break;
		case 7:
			if (rows != cols)
				printf("This is not a square matrix.\n");
			else
			{
				do
				{
					printf("Insert i: ");
					scanf("%d", &power);
				} while (power < 1);
				powMatrix(matrix, rows, power);
				gets(bc);
			}
			break;
		case 8:
			printf("Enter your desired sum: ");
			scanf("%d", &sum);
			printf("%d\n", subMatrixCount(matrix, rows, cols, sum));
			gets(bc);
			break;
		}
	} while (choice != 0);
	
	system("pause");
}

void printMenu()
{
	printf("1. Display the matrix.\n2. Insert values to the matrix.\n3. Transpose matrix.\n4. Sort the matrix by rows sum.\n");
	printf("5. Sort the whole matrix.\n6. Print matrix value.\n7. i-th power of matrix.\n8. Find sub matrix.\n0. Exit.\n");
	printf("Please enter your choice: ");
}
void printMatrix(int matrix[][50], int rows, int cols)
{
	int i, j;
	for (i = 0; i < rows; i++)
	{
		for (j = 0; j < cols; j++)
		{
			if (j == cols - 1)
				printf("%d\n", matrix[i][j]);
			else
				printf("%d ", matrix[i][j]);
		}
	}
}
int getMenu()
{
	int choice;
	char num[256];
	do
	{
		choice = -1;
		printMenu();
		gets(num);
		choice = menuCheck(num);
		if (choice == -1)
			printf("Wrong input, try again\n");
	} while (choice == -1);
	return choice;
}
void initMatrix(int matrix[][50], int rows, int cols)
{
	char st[12];
	int i, j;
	for (i = 0; i < rows; i++)
	{
		for (j = 0; j < cols; j++)
			scanf(" %d", &matrix[i][j]);
	}
	gets(st);//to clear the buffer before returning to main.

}
void transposeMatrix(int matrix[][50], int oldRows, int oldCols)
{
	int i, j, tempMatrix[50][50];
	for (i = 0; i < oldRows; i++)//copy the matrix.
	{
		for (j = 0; j < oldCols; j++)
			tempMatrix[i][j] = matrix[i][j];
	}
	for (i = 0; i < oldRows; i++)//transpose the matrix.
	{
		for (j = 0; j < oldCols; j++)
			matrix[j][i] = tempMatrix[i][j];
	}
}
void sortByRows(int matrix[50][50], int rows, int cols)
{//selection sort for rows.
	int i, j, iSumMin;
	for (i = 0; i < rows-1; i++)
	{
		iSumMin = i;
		for (j = i+1; j < rows; j++)
		{
			if (rowSum(matrix, iSumMin, cols) > rowSum(matrix, j, cols))
				iSumMin = j;
		}
		switchRows(i, iSumMin, matrix, cols);
	}

}
int rowSum(int matrix [50][50],int i, int cols)
{//return the sum of a given row. used if sortByRows function.
	int sum=0, j;
	for (i, j = 0; j < cols; j++)
		sum += matrix[i][j];
	return sum;
}
void switchRows(int i, int iSumMax, int matrix[50][50], int cols)
{//glasses switch in a bar with no table(for rows).
	int j, tempRow[50][50];
	for (i, j = 0; j < cols; j++)
	{
		tempRow[i][j] = matrix[i][j];
	}
	for (iSumMax, j = 0; j < cols; j++)
	{
		matrix[i][j] = matrix[iSumMax][j];
	}
	for (iSumMax, i, j = 0; j < cols; j++)
	{
		matrix[iSumMax][j] = tempRow[i][j];
	}
}
void sortMatrix(int matrix[][50], int rows, int cols)
{
	int arr[2500], i, j, l, s=rows*cols, iMin,temp;
	for (l=0, i = 0; i < rows; i++)//copy the matrix to one demitional array
		for (j = 0; j < cols; j++)
		{
			arr[l] = matrix[i][j];
			l++;
		}
	for (i = 0; i < s - 1; i++) //sort the array
	{
		iMin = i;
		for (j = i + 1; j < s; j++)
		{
			if (arr[iMin] > arr[j])
				iMin = j;
		}
		temp = arr[i];
		arr[i] = arr[iMin];
		arr[iMin] = temp;
	}
	for (l=0, i = 0; i < rows; i++)//copy back the one demitional array to the matrix
		for (j = 0; j < cols; j++)
		{
			matrix[i][j] = arr[l];
			l++;
		}
}
int matrixValue(int matrix[][50], int rows, int cols)
{
	int sum = 0, i, j;
	for (i = 0; i < rows; i++)
		for (j = 0; j < cols; j++)
			sum += matrix[i][j] * (i + 1)*(j + 1);
	return sum;
}
void powMatrix(int matrix[][50], int size, int matPower)
{
	int i, j, k, sum = 0, originalMatrix[50][50], powMatrix[50][50];
	for (i = 0; i < size; i++)// copy the original matrix so that her values will not be damaged in the multiplication.
	{
		for (j = 0; j < size; j++)
			originalMatrix[i][j] = matrix[i][j];
	}
	while (matPower-1 > 0)
	{
		for (i = 0; i < size; i++)//matrix multiplication.
		{
			for (j = 0; j < size; j++)
			{
				for (k = 0; k < size; k++)
				{
					sum += matrix[i][k] * originalMatrix[k][j];
				}
				powMatrix[i][j] = sum;//saves the sum in an temporary matrix.
				sum = 0;
			}
		}
		for (i = 0; i < size; i++)
		{
			for (j = 0; j < size; j++)
				matrix[i][j] = powMatrix[i][j];//copy back the result.
		}
		matPower--;
	}
}
int subMatrixCount(int matrix[][50], int rows, int cols, int sum)
{
	int  i, j, collCounter, rowCounter, l, q, verSizeCheck = 1, horSizeCheck = 1, totSum = 0, counter = 0;// ver=vertical, hor=horizontal.
	while (verSizeCheck <= rows)
	{
		while (horSizeCheck <= cols)
		{
			for (i = 0; i <= rows - verSizeCheck; i++)
			{
				for (j = 0; j <= cols - horSizeCheck; j++)
				{
					for (totSum = 0, l = j, q = i, collCounter = 0, rowCounter = 0; rowCounter < verSizeCheck; collCounter++, l++)
					{
						if (collCounter == horSizeCheck)//then its the end of the row in the examined matrix.
						{
							rowCounter++;
							collCounter = -1;
							l = j - 1;//so in the incremant, j and collCounter will reset to 0.
							q++;//to move on calculating the next row.
						}
						else totSum += matrix[q][l];
					}
					counter += (totSum == sum) ? 1 : 0;//that means the checked matrix sum equal to the wanted sum.
				}
			}
			horSizeCheck++;//determint the numbers of collums in the calculated matrix.
		}
		verSizeCheck++;//determint the numbers of rows in the calculated matrix.
		horSizeCheck = 1;
	}
	return counter;
}
int inputCheck (char num[256])
{
int i, flag1 = 1, j, sum;
	for (i = 0, sum=0, flag1 = 1; flag1 && num[i] != '\0'; )
	{
		if ((num[i] >= '0' && num[i] <= '9') || num[i] == ' ' || num[i] == '\t')//num[i] is an int, space or tab.
		{
			if (num[i] == ' ' || num[i]=='0' || num[i]=='\t') //white character or the end of the array.
				i++;
			else if ((num[i + 1] >= '0' && num[i + 1] <= '9') || num[i + 1] == ' ' || num[i+1] == '\t')// assuming num[i] is an int.
			{
				if (num[i + 1] == ' ' || num[i+1] == '\t')// one digit number check;
				{
					for (j = i - 1; j >= 0; j--)
					{
						if (num[j] == ' ')
							if (num[j - 1] == '0')
								return 0;
					}
					for (j = i + 2, flag1 = 1; flag1 && num[j] != '\0'; )
					{
						if (num[j] != ' ' && num[j] != '\t')// if the rest of the loop is anything but spaces or tabs.
							flag1 = 0;
						if (flag1)
							j++;
					}
					if (num[j] == '\0')
					{
						sum = num[i]-48;
						i = j;//ends the main loop.
					}
					else flag1 = 0;
				} //assuming num[i+1] is an int.
				else if (num[i + 2] == ' ' || num[i+2] == '\t')
				{
					for (j = i - 1; j >= 0; j--)
					{
						if (num[j] == ' ')
							if (num[j - 1] == '0')
								return 0;
					}
					for (j = i + 3, flag1 = 1; flag1 && num[j] != '\0'; )
					{
						if (num[j] != ' ' && num[j] != '\t')// if the rest of the loop is anything but spaces or tabs.
							flag1 = 0;
						if (flag1)
							j++;
					}
					if (num[j] == '\0')
					{
						if ((num[i] - 48) * 10 + (num[i + 1] - 48) <= 50)
						{
							sum = (num[i] - 48) * 10 + (num[i + 1] - 48);
							return sum; //ends the main loop
						}
						else flag1 = 0;
					}
					else flag1 = 0;
				}
				else if (num[i + 2] == '\0')
				{
					for (j = i - 1; j >= 0; j--)
					{
						if (num[j] == ' ')
							if (num[j - 1] == '0')
								return 0;
					}
					if ((num[i] - 48) * 10 + (num[i + 1] - 48) <= 50)
					{
						sum = (num[i] - 48) * 10 + (num[i + 1] - 48);
							return sum;
					}
					else flag1 = 0;
				}
				else flag1 = 0;
			}
			else if (num[i + 1] == '\0')
			{
				for (j = i - 1; j >= 0; j--)
				{
					if (num[j] == ' ')
						if (num[j-1]=='0')
						return 0;
				}
				sum = num[i]-48;
				i++;
			}
			else
				flag1 = 0;
		}
		else
			flag1 = 0;
	}

	if (num[i] == '\0') //if the loop ends at the ends witout interraption.
		return (sum);
	else return 0;
}
int menuCheck(char num[256])
{
	int i, j;
	for (i = 0; num[i] != '\0'; )
	{
		if ((num[i] >= '0' && num[i] <= '8') || num[i] == ' ' || num[i]=='\t')//num[i] is an int, space or tab.
		{
			if (num[i] == ' ' || num[i] == '\t') //if space continue the loop.
				i++;
			else for (j = i+1; num[j] != '\0'; )//assuming num[i] is an int.
			{
				if (num[j] != ' ' && num[j] != '\t')// makes sure the rest of the loop is nothing but spaces and tabs.
					return -1;
				j++;
			}
			return (num[i]-48);
		}
		else return -1;
	}
	if (i == 0)
		return -1;
}