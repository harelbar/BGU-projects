#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct person_ {
	char name[31];
	char id[10];
	char genes[5][22];
} person;
typedef struct potential_donairs {
	char name[31];
	char id[10];
	char genes[5][22];
	int matchingGenes;
	int mis[5];
} pd;

void createDatabase(FILE** units, int numberOfUnits, char* filename);
int compare(char** arr, int numberOfUnits, char** ok, FILE** units);
person* getPotentialDonors(char* database, person patient, int min_match, int* size);
person * sortDonors(pd *p, int size, int min_match);
void printPotentialDonorsList(person* potentialDonors, int size);


void main()
{
	FILE** units;
	person patient, *potentialDonors = NULL;
	int min_match, size=0 , choice, numberOfUnits, i, somesize = 10;
	char str[20], name[100], databaseName1[100], databaseName[20], clear[5];
	
	do
	{
		do
		{
			printf("*** Main Menu ***\n1.Unify Database\n2.Find Potential Donors\n");
			printf("3.Print The List of Potential Donors\n4.Exit\nEnter Your Selection:\n");
			scanf("%d", &choice);
		} while (choice < 1 || choice>4);
		switch (choice)
		{
		case 1:
			printf("Enter units root name:\n");
			scanf("%s", str);
			printf("Enter the number of units:\n");
			scanf("%d", &numberOfUnits);
			printf("Enter the new database name:\n");
			scanf("%s", databaseName1);
			sprintf(databaseName, "%s.txt", databaseName1);
			if (!(units = (FILE*)malloc(numberOfUnits * sizeof(FILE))))
			{
				printf("memory allocation faild");
				exit(1);
			}
			for (i = 0; i < numberOfUnits; i++)
			{
				sprintf(name, "%s%d.txt", str, i + 1);
				if ((units[i] = fopen(name, "r")) == NULL)
				{
					printf("opening file #%d has faild", i);
					while (i >= 0)
						fclose(units[i--]);
					free(units);
					exit(1);
				}
			}
			createDatabase(units, numberOfUnits, databaseName);
			break;
		case 2:
			gets(clear);
			printf("Enter Genes DNA Sequences:\n");
			for (i = 0; i < 5; i++)
			{
				printf("Gene %d:\n", i+1);
				gets(patient.genes[i]);
			}
			printf("Enter Minimal Match:\n");
			scanf("%d", &min_match);
			printf("Enter The Database Filename:\n");
			gets(clear);
			gets(name);
			sprintf(databaseName, "%s.txt", name);
			potentialDonors = getPotentialDonors(databaseName, patient, min_match, &size);
			break;
		case 3:
			printf("Potential Donors Details\n------------------------\n");
			printPotentialDonorsList(potentialDonors, size);
			break;
		}
	} while (choice != 4);
}

void createDatabase(FILE** units, int numberOfUnits, char* filename)
{
	FILE *file;
	file = fopen(filename, "w");
	int i, j, flag = 1;
	long id;
	char **names, **ok, DNA[111];
	names = (char*)malloc(31 * sizeof(char)); //31 is the max lenth of a name.
	ok = (char*)malloc(numberOfUnits * sizeof(char));
	if (names == NULL || ok == NULL)
	{
		printf("memory allocation faild");
		exit(1);
	}
	for (i = 0; i<numberOfUnits; i++) {
		names[i] = (char*)malloc(31 * sizeof(char));
	}
	for (i = 0; i<numberOfUnits; i++) {
		ok[i] = (char*)malloc(31 * sizeof(char));
	}
	for (i = 0; i < numberOfUnits; i++) //insert all of the firsts names of each file into an matrix.
	{
		ok[i] = fgets(names[i], 32, units[i]);
	}
	while (flag)
	{
		flag = 0;
		j = compare(names, numberOfUnits, ok, units);
		if (j == -1)
			break;
		fscanf(units[j], "%9ld%110[^$]%*c", &id, DNA);//21*5 with space befour each one=110.
		fprintf(file, "%30s%ld%110s\n", names[j], id, DNA);
		ok[j] = fgets(names[j], 31, units[j]);
		for (i = 0; i < numberOfUnits && !flag; i++)
			flag = ok[i] != NULL ? 1 : 0;//checks if there at least one file who hasn't reached EOF;
	}
	fclose(file);
}
int compare(char **arr, int numberOfUnits, char **ok, FILE **units)//returns the index of the min lexicografy name.
{
	int min, i, j = 0, res;
	long id;
	char DNA[111], stri[32] = { 0 }, strmin[32] = { 0 };
	while (j < numberOfUnits)//fines the first file that hasn't ended and sets the minimum index to his.
	{
		if (ok[j] != NULL)
		{
			min = j;
			break;
		}
		j++;
	}
	if (j == numberOfUnits)//means all of the files has ended.
		return -1;
	i = j + 1;
	while (i < numberOfUnits)
	{
		if (ok[i] != NULL) //makes sure we don't compare names that their files has ended.
		{

			strcpy(stri, arr[i]);
			strcpy(strmin, arr[min]);
			res = strcmp(strmin, stri);
			switch (res)
			{
			case 1:
				min = i;
				i++;
				break;
			case -1://min stays the same.
				i++;
				break;
			case 0:
				fscanf(units[i], "%9ld%110[^$]%*c", &id, DNA);//skips the identical name.
				ok[i] = fgets(arr[i], 32, units[i]);//i and min stays the same, and we procced to the next name in the i'th file.
				break;
			}
		}
		else i++;
	}
	return min;
}
person* getPotentialDonors(char* database, person patient, int min_match, int *size)
{
	pd *p1, *temp1;
	person *p2, *temp2, *sortedList;
	FILE *data;
	int i = 0, j = 0, k = 0, m = 0, n = 0, ok = 3, mismatches = 0, match = 0, initialSize = 5, counter=0;
	p1 = (pd*)malloc(initialSize * sizeof(person));
	p2 = (person*)malloc(initialSize * sizeof(pd));

	if ((data = fopen(database, "r")) == NULL)
	{
		printf("faild");
		exit(1);
	}

	while (ok == 3)
	{
		ok = fscanf(data, "%31[^$]%9s%111[^$]", p1[i].name, p1[i].id, p1[i].genes);
		if (ok != 3)
			break;
		counter++;
		for (j = 0; j < 5; j++)
		{
			for (k = 0, mismatches = 0; k < 22; k++)
			{
				if (p1[i].genes[j][k] != patient.genes[j][k])
					mismatches++;
			}
			p1[i].mis[j] = mismatches;
		}
		for (i = 0; i < initialSize; i++)
		{
			for (j = 0, match = 0; j < 5; j++)
			{
				if (p1[i].mis[j] == 0)
					match++;
			}
			p1[i].matchingGenes = match;
		}
		i++;
		if (i == initialSize)//then we need a bigger array.
		{
			temp1 = (pd*)malloc(initialSize * 2 * sizeof(person));
			temp2 = (person*)malloc(initialSize * 2 * sizeof(pd));
			for (m = 0; m < initialSize; m++)
			{
				strcpy(temp1[m].name, p1[m].name);
				strcpy(temp1[m].id, p1[m].id);
				strcpy(temp1[m].genes, p1[m].genes);
				for (n = 0; n < 5; n++)
				{
					temp1[m].mis[n] = p1[m].mis[n];
				}
				temp1[m].matchingGenes = p1[m].matchingGenes;
				strcpy(temp2[m].name, p2[m].name);
				strcpy(temp2[m].id, p2[m].id);
				strcpy(temp2[m].genes, p2[m].genes);
			}
			initialSize *= 2;
			p1 = temp1;
			p2 = temp2;
			free(temp1);
			free(temp2);
		}
	}
	sortedList = sortDonors(p1, i-1, min_match);
	fclose(data);
	*size = i;
	return p1;
}
person * sortDonors(pd *p, int size, int min_match)
{
	person* sortedList;
	int i, j = 0, maxIndex = 0, lastMax = 1;
	sortedList = (person*)malloc(size * sizeof(person));
	while (p[maxIndex].matchingGenes >= min_match && lastMax != maxIndex)
	{
		maxIndex = 0;
		for (i = 1; i < size; i++)
		{
			if (p[i].matchingGenes > p[maxIndex].matchingGenes)//compare the matching genes. 1'st criteria
			{
				maxIndex = i;
			}
			else if (p[i].matchingGenes == p[maxIndex].matchingGenes)//then we need to compare the mismatches.
			{
				if (p[i].mis < p[maxIndex].mis)//compare the mismatches. 2'nd criteria
				{
					maxIndex = i;
				}
				else if (p[i].mis == p[maxIndex].mis)//then we need to compair their names.
				{
					if ((strcmp(p[maxIndex].name, p[i].name)) == -1)
					{
						maxIndex = i;
					}
				}
			}
		}
		if (lastMax != maxIndex && p[maxIndex].matchingGenes >= min_match)
		{
			lastMax = i;
			strcpy(sortedList[j].name, p[maxIndex].name);//a sorted list of persons.
			strcpy(sortedList[j].id, p[maxIndex].id);
			strcpy(sortedList[j].genes, p[maxIndex].genes);
			p[maxIndex].matchingGenes = -1;//to remove the maximum from the sorting.
			j++;
		}


	}//lastMax==maxIndex in case all of the list went into the sorted list.
	return sortedList;
}
void printPotentialDonorsList(person* potentialDonors, int size)

{
	int i;
	for (i = 0; i < size; i++)
	{
		printf("%31s%9s", potentialDonors[i].name, potentialDonors[i].id);
	}
}