#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

# define SIZE 9
typedef struct node node;
typedef struct HuffmanTree HuffmanTree;
struct node
{
	HuffmanTree* head;
	node *next;
};

struct HuffmanTree
{
	char ch;
	int freq;
	HuffmanTree *parent;
	HuffmanTree * left ;
	HuffmanTree * right ;
};

char * convertToBinary(int num);
int freq(char ch, char str[]);
node* creatNode(char c, int f);
HuffmanTree *creatTree(char c, int f);
node * creatSortedList(node *h, node *newNode);
node *creatHuffmanTree(node* list);
void printList(node* h);
int printMenu1();
node *makeTree(char *str);
char *myStrcpy(char str1[], char str2[]);
void myFree(HuffmanTree* n);
int printMenu2();
char *encode(HuffmanTree * tree, char c, char str[9], int i);
void printLeaves(HuffmanTree * tree);
void deCode(HuffmanTree* tree, HuffmanTree* original, char str[], int i);
char convertFromBin(char str[9]);
void enString(node *head1, char enStr[]);
void fromBinToChar(HuffmanTree* tree, char enStr[], char t[]);
void convertStringToBin(char str[], char temp[]);


void main()
{
	int choice, i=0, j=0,k=0, f;
	char ch;
	char str1[10000] = { 0 }, str3[10000] = { 0 }, enStr1[10000] = { 0 }, temp[100] = { 0 };
	char str2[256][16], temp2[16], enStr2[10000] = { 0 };
	int len;
	node *node, *head1=NULL;
	do
	{
		choice = printMenu1();
		switch (choice)
		{
		case 1:
			gets(str1);
			head1 = makeTree(str1);
			head1->head->parent = NULL;
			break;
		case 2:
			do
			{
				gets(str2[i++]);
			} while (str2[i - 1][0] != '\0');

			i = 0;
			while (str2[i][0] != '\0')
			{
				ch = str2[i][0];
				myStrcpy(temp2, str2[i]);
				f = atoi(temp2);
				node = creatNode(ch, f);
				head1 = creatSortedList(head1, node);
				i++;
			}
			while (head1->next != NULL)
				head1 = creatHuffmanTree(head1);
			head1->head->parent = NULL;
			break;
		case 3:
			if (head1 != NULL)
			{
				myFree(head1->head);
				head1 = NULL;
			}
			exit(1);
		}
		do
		{
			choice = printMenu2();
			switch (choice)
			{
			case 1:
				enString(head1, enStr1);
				printf("%s\n",enStr1);
				break;

			case 2:	
				enString(head1, enStr2);
				fromBinToChar(head1->head, enStr2, temp);
				printf("%s\n", temp);
				break;

			case 3:
				gets(str1);
				deCode(head1->head, head1->head, str1, 0);
				putchar('\n');
				break;

			case 4:
				gets(str1);
				convertStringToBin(str1, str3);
				printf("%s\n", str3);
				break;

			case 5:
				printLeaves(head1->head);
				break;
			case 6:
				myFree(head1->head);
				head1 = NULL;
				break;
			}
		} while (head1 != NULL);
	} while (head1 == NULL);
	
}
char * convertToBinary(int num)
{
	int i, a;
	char str[SIZE];
	str[SIZE - 1] = '\0';
	for (i = 7; i >= 0, num > 0; i--)
	{
		a = pow(2, i);
		if (num - a >= 0)
		{
			num -= a;
			str[SIZE - i - 2] = '1';
		}
		else
			str[SIZE - i - 2] = '0';
		if (num == 0)
		{
			for (i -= 1; i >= 0; i--)
				str[SIZE - i - 2] = '0';
		}
	}
	return str;
}
void convertStringToBin(char str[], char temp[])
{
	int i;
	char t[100] = { 0 };
	for (i = 0; str[i] != '\0'; i++)
		strcat(t, convertToBinary((int)str[i]));
	strcpy(temp, t);
	temp[strlen(temp)] = '\0';
	return;
}
int freq(char ch, char str[])
{
	int f=0, i;
	for (i=0 ; str[i] != '\0'; i++)
	{
		if (str[i] == ch)
			f++;
	}
	return f;
}
node* creatNode(char c, int f)
{
	node *n;
	n = malloc(sizeof(node));
	n->head = creatTree(c, f);
	n->next = NULL;
	return n;
}
HuffmanTree *creatTree(char c, int f)
{
	HuffmanTree * tree;
	tree = malloc(sizeof(HuffmanTree));
	tree->ch = c;
	tree->freq = f;
	tree->parent = NULL;
	tree->left = NULL;
	tree->right = NULL;
	return tree;
}
node * creatSortedList(node *h, node *newNode)
{
	node* i=NULL, *j=NULL;
	if (!h)//tree is empty.
		return newNode;
	node* H = h->next, *p=h;
	if (h->head->freq > newNode->head->freq)
	{
		newNode->next = h;
		return newNode;
	}
	if (h->head->freq == newNode->head->freq)
	{
		if ((unsigned char)(h->head->ch) > (unsigned char)(newNode->head->ch))
		{
			newNode->next = h;
			return newNode;
		}
		while (H != NULL)
		{
			if (H->head->freq > newNode->head->freq)
			{
				newNode->next = H;
				p->next = newNode;
				return h;
			}
			if ((unsigned char)(H->head->ch) > (unsigned char)(newNode->head->ch))
			{
				newNode->next = H;
				p->next = newNode;
				return h;
			}
			p = p->next;
			H = H->next;
		}
		p->next = newNode;
		return h;
	}
	while (H != NULL)
	{
		if (H->head->freq > newNode->head->freq)
		{
			newNode->next = H;
			p->next = newNode;
			return h;
		}
		if (H->head->freq == newNode->head->freq)
		{
			if ((unsigned char)(H->head->ch) > (unsigned char)(newNode->head->ch))
			{
				newNode->next = H;
				p->next = newNode;
				return h;
			}
		}
		p = p->next;
		H = H->next;
	}
	p->next = newNode;
	return h;	
}
void printList(node* h)
{
	if (!h)
		return;
	printf("%c,%d\t", h->head->ch, h->head->freq);
	printList(h->next);
}
node *creatHuffmanTree(node* list)
{
	node *temp, *n1;
	HuffmanTree *hu;
	hu = malloc(sizeof(HuffmanTree));
	n1 = malloc(sizeof(node));
	list->head->parent = hu;
	list->next->head->parent = hu;
	hu->left = list->head;       //lowest preferrenc.
	hu->right = list->next->head;//second lowest.
	hu->freq = list->head->freq + list->next->head->freq;
	hu->ch = list->head->ch;
	n1->head = hu;
	n1->next = NULL;
	list = creatSortedList(list, n1);//enter the new node wich holds the Huffman tree into the sorted list.
	temp = list->next->next;
	free(list->next);
	free(list);
	return temp;
}
int printMenu1()
{
	char str[10];
	int choice;
	do
	{
		printf("--- No Huffman Tree ---\n");
		printf("1. Create a Huffman Tree from text\n2. Deserialize a Huffman Tree\n3. Exit\nEnter you choice: ");
		gets(str);
		choice = atoi(str);
	} while (choice < 1 || choice > 3);
	return choice;
}
node *makeTree(char *str)
{
	int i, j, flag = 1, f;
	node* headOfList = NULL;
	for (i = 0; str[i] != '\0'; flag = 1, i++)
	{
		for (j = 0; flag&& j < i; j++)
			flag = str[i] == str[j] ? 0 : 1;//checks if the freq for this char has already bean calculated.
		if (flag)//if its the first time, do 
		{
			f = freq(str[i], str);
			headOfList = creatSortedList(headOfList, creatNode(str[i], f));
		}
	}
	while (headOfList->next != NULL)
		headOfList = creatHuffmanTree(headOfList);
	return headOfList;
}
char *myStrcpy(char str1[], char str2[])
{
	int i=0, j=-2;
	while (str2[i] != '\0')
	{
		if (j >= 0)
		{
			str1[j] = str2[i];
		}
		i++;
		j++;
	}
	str1[j] = '\0';
	return str1;
}
void myFree(HuffmanTree* h)
{
	if (h == NULL)
		return;
	myFree(h->left);
	myFree(h->right);
	free(h);
}
int printMenu2()
{
	char str[10];
	int choice;
	do
	{
		printf("*** Huffman Tree in-memory ***\n");
		printf("1. Encode text using the Huffman Tree\n2. Bit-encode text using the Huffman Tree\n");
		printf("3. Decode using the Huffman Tree\n4. Bit-decode using the Huffman Tree\n5. Serialize the Huffman Tree\n");
		printf("6. Free the in-memory Huffman Tree\nEnter you choice: ");
		gets(str);
		choice = atoi(str);
	} while (choice < 1 || choice > 6);
	return choice;
}
char *encode(HuffmanTree * tree, char c, char str[9], int i)
{
	static int flag = 1;
	if (flag == 0)
		return str;
	if (tree->parent != NULL)
	{
		if (tree == tree->parent->left)
			str[i] = '0';
		if (tree == tree->parent->right)
			str[i] = '1';
	}
	if (tree->left == tree->right)
	{
		if (tree->ch == c)
		{
			flag = 0;
			str[i + 1] = '\0';
			return str;
		}
		return str;
	}
	encode(tree->left, c, str, i + 1);
	encode(tree->right, c, str, i + 1);
	if (tree->parent == NULL)
		flag = 1;
	return str;
}
void printLeaves(HuffmanTree * tree)
{
	if (tree == NULL)
		return;
	printLeaves(tree->left);
	if (tree->left == tree->right)
	{
		printf("%c:%d\n", tree->ch, tree->freq);
	}
	printLeaves(tree->right);
}
void deCode(HuffmanTree* tree, HuffmanTree* original, char str[], int i)
{
	static int flag2 = 1;
	if (flag2 == 0)
	{
		flag2 = 1;
		return;
	}
	if (tree->left == tree->right)
	{
		printf("%c", tree->ch);
		if (tree->ch == '@')//means its the end of the string.
			flag2 = 0;
		deCode(original, original, str, i);
	}
	else if (str[i] == '0')
		deCode(tree->left, original, str, i + 1);
	else deCode(tree->right, original, str, i + 1);

}
char convertFromBin(char str[9])//convert a binary code to char.
{
	int i, c=0;
	for (i = 0; i < 8; i++)
	{
		if (str[i] == '1')
			c += pow(2, 7-i);
	}
	return (char)(c);
}
void enString(node *head1, char enStr[])
{
	char *string, str[9] = { 0 };
	int i=0, len;
	string = (char*)malloc(10);
	gets(str);
	while (str[i] != '\0')
	{
		string = encode(head1->head, str[i], string, -1);//string now has the encoded str.
		strcat(enStr, string);                           //append string to encoded Str.
		i++;
	}
	free(string);
	len = strlen(enStr);
	while (len % 8 != 0)
		enStr[len++] = '0';
	return ;
}
void fromBinToChar(HuffmanTree* tree, char enStr[], char t[])
{
	int i, j, k;
	char temp1[9] = { 0 };
	for (i = 0, j = 0, k = 0; enStr[j] != '\0'; j++, i++)
	{
		temp1[i] = enStr[j];
		if (i == 7)
		{
			t[k] = convertFromBin(temp1);
			k++;
			i = -1;
		}
	}
	t[k] = '\0';
}