#Install dependencies globally
${function:npmg} = { npm i -g }
#Install and save to dependencies in your package.json
${function:npmS} = { npm i -S }
#Install and save to dev-dependencies in your package.json
${function:npmD} = { npm i -D }
#Run npm start Dev
${function:npmRD} = { npm run dev }
#Run npm start server
${function:npmRS} = { npm run server }
#Run npm build
${function:npmB} = { npm run build }
