data Node a = Node a [Node a]
instance (Eq a) => Eq (Node a) where
    (Node a _) == (Node b _) = a == b

type Graph a = [Node a]

hasCycle :: (Eq a) => Graph a -> Bool
hasCycle graph = any hasCycle' graph

hasCycle' :: (Eq a) => Node a -> Bool
hasCycle' origin = hasCycle'' origin origin []

hasCycle'' :: (Eq a) => Node a -> Node a -> [Node a] -> Bool
hasCycle'' origin current@(Node _ neighbors) visited
    | elem current visited = True
    | otherwise = any (\n -> hasCycle'' current n (current:visited)) $ filter (\n -> n /= origin) neighbors

    
pathExists :: (Eq a) => Node a -> Node a -> Bool
pathExists origin goal = pathExists' origin goal []

pathExists' :: (Eq a) => Node a -> Node a -> [Node a] -> Bool
pathExists' origin current@(Node _ neighbors) visited
    | elem origin neighbors = True
    | elem current visited = False
    | otherwise = any (\n -> pathExists' origin n (current:visited)) $ filter (\n -> n /= origin) neighbors