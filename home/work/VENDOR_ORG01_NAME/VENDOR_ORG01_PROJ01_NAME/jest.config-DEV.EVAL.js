// USAGE:
//   m4_shim \
//     "+10" "home/work/VENDOR_ORG01_NAME/VENDOR_ORG01_PROJ01_NAME/jest.config-DEV.EVAL.js" \
//     "home/${DXY_DEPOXY_VENDOR_HOME_NAME}/${DXY_VENDOR_ORG01_NAME}/${DXY_VENDOR_ORG01_PROJ01_NAME}/jest.config-DEV.js"

// vim:tw=0:ts=2:sw=2:et:norl:ft=javascript

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

// DXY_HEADER_AUTHOR
// DXY_HEADER_PROJECT
// DXY_HEADER_LICENSE

// SPIKE/2021-01-22: Does `jest -b` work with this file?
module.exports = {
  moduleNameMapper: {
    '^.+\\.(css|less|scss)$': 'identity-obj-proxy',
    '^.+.svg$': '<rootDir>/test-setup/mock-svg.js',
    '^react-redux$': '<rootDir>/test-setup/mock-react-redux.js',
    '@opentok/client': '<rootDir>/test-setup/mock-opentok-client.js'
  },
  moduleDirectories: [
    'src',
    'node_modules'
  ],
  setupFiles: [
    './test-setup/enzyme-adapter.js',
    './test-setup/globals.js'
  ],
  setupFilesAfterEnv: [
    './test-setup/enzyme-container.js'
  ],
  testPathIgnorePatterns: [
    'webpack/*',
  ],
  // This entry is unique to another project:
  //  transformIgnorePatterns: [
  //    'node_modules/(?!@BIZUNIT/ANOTHERPROJECT)'
  //  ],
  coverageThreshold: {
    global: {
      branches: 85,
      functions: 85,
      lines: 85,
      statements: 85
    }
  },
  collectCoverageFrom: [
    'src/**/*.js',
    'src/**/*.jsx',
    'src/**/*.ts',
    '!src/components/video/video-filtering/setup/tflite.js',
    '!src/polyfills/*',
    // Design Pattern Libraries:
    '!src/public/dpl/COMPANY_NAME1/*',
    '!src/public/dpl/COMPANY_NAME2/*'
  ],

  // ***

  // So that 'document', 'window', etc., are available.
  testEnvironment: 'jsdom',

  // ***

  // SAVVY/2021-01-22: This is the jest.timeout() option, which defaults 5000.
  testTimeout: 600000,

  // ***

  // https://basarat.gitbook.io/typescript/intro-1/jest
  // "roots": [
  //   "<rootDir>/src"
  // ],
  // "testMatch": [
  //   "**/__tests__/**/*.+(ts|tsx|js)",
  //   "**/?(*.)+(spec|test).+(ts|tsx|js)"
  // ],
  // "transform": {
  //   "^.+\\.(ts|tsx)$": "ts-jest"
  // },
  transform: {
    '^.+\\.jsx?$': '<rootDir>/node_modules/babel-jest',
    '^.+\\.tsx?$': 'ts-jest'
  }
};
